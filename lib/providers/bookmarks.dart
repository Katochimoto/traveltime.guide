import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/store/models/user_bookmark.dart';

class Bookmarks {
  Bookmarks();
}

class BookmarksController extends AsyncNotifier<Bookmarks> {
  late Isar _db;

  @override
  Future<Bookmarks> build() async {
    _db = await ref.watch(dbProvider.future);
    return Bookmarks();
  }

  Future<void> addPoint(Point point) async {
    state = await AsyncValue.guard(() async {
      await _db.writeTxn(() async {
        final bookmarks = _db.collection<UserBookmark>();
        bookmarks.put(UserBookmark.createPointBookmark(point));
      });
      return Bookmarks();
    });
  }

  Future<void> removePoint(Point point) async {
    state = await AsyncValue.guard(() async {
      await _db.writeTxn(() async {
        await _db
            .collection<UserBookmark>()
            .filter()
            .typeEqualTo(UserBookmarkType.point)
            .objectIdEqualTo(point.id)
            .deleteAll();
      });
      return Bookmarks();
    });
  }
}

final bookmarksProvider =
    AsyncNotifierProvider<BookmarksController, Bookmarks>(() {
  return BookmarksController();
});
