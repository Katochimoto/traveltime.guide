import 'package:isar/isar.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'user_favorite.g.dart';

enum UserFavoriteType {
  point,
  article,
}

@collection
class UserFavorite {
  UserFavorite({
    required this.id,
    required this.type,
    required this.favoriteId,
  });

  final String id;

  Id get isarId => fastHash(id);

  @enumerated
  @Index(type: IndexType.value)
  final UserFavoriteType type;

  @Index(unique: true, composite: [CompositeIndex('type')])
  final String favoriteId;

  factory UserFavorite.fromJson(data) {
    return UserFavorite(
      id: data['id'],
      type: UserFavoriteType.values.byName(data['type']),
      favoriteId: data['favoriteId'],
    );
  }
}
