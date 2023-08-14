import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/utils/url_launch.dart';

class OverviewContentTag {
  OverviewContentTag({required this.text, this.color});
  final String text;
  final Color? color;
}

class OverviewContent extends StatelessWidget {
  const OverviewContent({
    super.key,
    this.sc,
    this.title,
    this.subtitle,
    this.actions,
    this.content,
    this.coverImage,
    this.extra,
    this.tags,
  });

  final ScrollController? sc;
  final String? title;
  final String? subtitle;
  final String? content;
  final String? coverImage;
  final List<Widget>? actions;
  final List<Widget>? extra;
  final List<OverviewContentTag>? tags;

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.merge(Typography.whiteCupertino);
    final tagStyle =
        Theme.of(context).textTheme.merge(Typography.whiteCupertino).bodySmall;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          flex: 2,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: coverImage != null
                      ? DecorationImage(
                          image: NetworkImage(coverImage!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/imgs/drawer_bg.jpg'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(decoration: const BoxDecoration(color: Colors.black45)),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: UIGap.g2, left: UIGap.g3, right: UIGap.g3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(title!, style: textStyle.headlineSmall),
                    if (tags?.isNotEmpty == true)
                      Padding(
                        padding: const EdgeInsets.only(bottom: UIGap.g1),
                        child: Row(
                          children: [
                            for (final tag in tags!)
                              Container(
                                decoration: BoxDecoration(
                                    color: tag.color,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(UIGap.g1))),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: UIGap.g2),
                                child: Text(
                                  tag.text,
                                  style: tagStyle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    if (subtitle != null)
                      Text(subtitle!, style: textStyle.bodySmall),
                    if (actions != null && actions!.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: actions!,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: ListView(
            controller: sc,
            padding: const EdgeInsets.all(UIGap.g3),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              if (content != null)
                MarkdownBody(
                  data: content!,
                  onTapLink: (text, href, title) => urlLaunch(href),
                ),
              if (extra != null && extra!.isNotEmpty) ...extra!,
            ],
          ),
        ),
      ],
    );
  }
}
