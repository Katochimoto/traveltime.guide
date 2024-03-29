import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/utils/url_launch.dart';
import 'package:traveltime/widgets/not_found.dart';
import 'package:traveltime/widgets/page_layout.dart';
import 'package:traveltime/store/models.dart' as models;

class StaticView extends ConsumerWidget {
  const StaticView({
    super.key,
    required this.type,
  });

  final models.PageType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(pageProvider(type)).when(
          data: (data) => data == null
              ? const NotFound()
              : PageLayout(
                  scroll: false,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: UIGap.g2),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      MarkdownBody(
                        data: data.content,
                        onTapLink: (text, href, title) => urlLaunch(href),
                      ),
                    ],
                  ),
                ),
          error: (error, stackTrace) => const NotFound(),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
