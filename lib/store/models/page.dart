import 'package:isar/isar.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'page.g.dart';

enum PageType {
  about,
  terms,
  disclaimer,
  policy,
}

@collection
class Page {
  Page({
    required this.id,
    required this.locale,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.content,
    required this.type,
  });

  final String id;

  Id get isarId => fastHash(id);

  @Enumerated(EnumType.name)
  final AppLocale locale;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  final String content;

  @Enumerated(EnumType.name)
  @Index(type: IndexType.value)
  final PageType type;

  factory Page.fromJson(data) {
    return Page(
      id: data['id'],
      locale: AppLocale.values.byName(data['locale']),
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      publishedAt: DateTime.parse(data['publishedAt']),
      content: data['content'],
      type: PageType.values.byName(data['type']),
    );
  }

  static List<Page> fromJsonList(List<dynamic> data) {
    return data
        .map<Page>((item) => Page.fromJson(item))
        .toList(growable: false);
  }
}
