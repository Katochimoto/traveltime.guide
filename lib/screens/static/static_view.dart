import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/not_found.dart';
import 'package:traveltime/widgets/page_layout.dart';

class StaticView extends ConsumerWidget {
  const StaticView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(eventsProvider).when(
          data: (data) => data.isEmpty
              ? const NotFound()
              : PageLayout(
                  scroll: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: UIGap.g2),
                    child: MarkdownBody(data: '# asd \nasdasd'),
                  ),
                ),
          error: (error, stackTrace) => const NotFound(),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
