import 'package:isar/isar.dart';
import 'package:traveltime/utils/app_auth.dart';

part 'article.g.dart';

@collection
class Article {
  Article(
      {required this.id,
      required this.country,
      required this.locale,
      required this.createdAt,
      required this.updatedAt,
      required this.publishedAt,
      required this.title,
      required this.description,
      this.intro,
      this.logoImg,
      this.coverImg});

  final Id id;

  final String country;

  @enumerated
  final AppLocale locale;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  @Index(type: IndexType.value)
  final String title;
  final String description;
  final String? intro;
  final String? logoImg;
  final String? coverImg;

  factory Article.fromJson(data) {
    return Article(
      id: data['id'],
      country: data['country'],
      locale: AppLocale.values.byName(data['locale']),
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      publishedAt: DateTime.parse(data['publishedAt']),
      title: data['title'],
      intro: data['intro'],
      description: data['description'],
      logoImg: data['logoImg'],
      coverImg: data['coverImg'],
    );
  }
}
