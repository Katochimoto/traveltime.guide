import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/widgets/overview/overview_content.dart';
import 'package:traveltime/widgets/overview/overview_web.dart';
import 'package:traveltime/widgets/page_layout.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({super.key, required this.article});

  final models.Article article;

  @override
  Widget build(BuildContext context) {
    return OverviewContent(
      coverImage: article.coverImg,
      title: article.title,
      // subtitle: article.,
      content: article.description,
      actions: [
        if (article.web != null) OverviewWeb(url: article.web!),
      ],
      extra: [
        // const PhotoAlbum(imgArray: [
        //   "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
        //   "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
        //   "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80",
        //   "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80",
        //   "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80",
        //   "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80",
        // ])
      ],
    );
  }
}
