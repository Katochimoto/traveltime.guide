import 'package:isar/isar.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/utils/fast_hash.dart';
import 'package:uuid/uuid.dart';

part 'user_bookmark.g.dart';

enum UserBookmarkType {
  point,
  route,
  article,
}

@collection
class UserBookmark {
  UserBookmark({
    required this.id,
    required this.type,
    required this.objectId,
  });

  final String id;

  Id get isarId => fastHash(id);

  @enumerated
  @Index(type: IndexType.value)
  final UserBookmarkType type;

  @Index(unique: true, composite: [CompositeIndex('type')])
  final String objectId;

  factory UserBookmark.fromJson(data) {
    return UserBookmark(
      id: data['id'],
      type: UserBookmarkType.values.byName(data['type']),
      objectId: data['objectId'],
    );
  }

  factory UserBookmark.createPointBookmark(Point point) {
    return UserBookmark(
      id: const Uuid().v4(),
      type: UserBookmarkType.point,
      objectId: point.id,
    );
  }
}
