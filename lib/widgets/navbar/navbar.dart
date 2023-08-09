import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/theme.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? categories;
  final Widget? search;
  final bool isTransparent;
  final VoidCallback? onBack;

  const Navbar({
    super.key,
    this.title,
    this.categories,
    this.search,
    this.onBack,
    this.isTransparent = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(UINavbar.hMenu +
      (search != null ? UINavbar.hSearch : 0) +
      (categories != null ? UINavbar.hCategories : 0) +
      (search != null && categories != null ? UIGap.g1 : 0));

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;
    final scaffold = Scaffold.of(context);
    return Container(
        height: preferredSize.height + safePadding,
        decoration: BoxDecoration(
            color: isTransparent
                ? Colors.transparent
                : Theme.of(context).canvasColor,
            boxShadow: isTransparent
                ? []
                : [
                    BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: -15,
                        blurRadius: 12,
                        offset: const Offset(0, 5))
                  ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: UIGap.g0, horizontal: UIGap.g2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _iconButton(
                        context,
                        onPressed: onBack != null
                            ? () => onBack!()
                            : () => scaffold.openDrawer(),
                        icon: onBack != null ? Icons.arrow_back : Icons.menu,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Obx(() =>
                          //     AppService.to.syncStatus == SyncStatus.progress
                          //         ? _iconButton(
                          //             context,
                          //             icon: Icons.sync,
                          //             inProgress: true,
                          //           )
                          //         : AppService.to.syncStatus == SyncStatus.error
                          //             ? _iconButton(
                          //                 context,
                          //                 icon: Icons.sync_problem,
                          //                 iconColor: Theme.of(context)
                          //                     .colorScheme
                          //                     .error,
                          //               )
                          //             : const SizedBox.shrink()),
                          // Obx(() => AppService.to.isOnline
                          //     ? const SizedBox.shrink()
                          //     : _iconButton(
                          //         context,
                          //         icon: Icons.wifi_off_outlined,
                          //       )),
                        ],
                      ),
                    ),
                    if (title != null)
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Text(
                            title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                  ],
                ),
                ...(search != null ? [Container(child: search)] : []),
                ...(categories != null && search != null
                    ? [const SizedBox(height: UIGap.g1)]
                    : []),
                ...(categories != null ? [Container(child: categories)] : []),
              ],
            ),
          ),
        ));
  }

  Widget _iconButton(
    BuildContext context, {
    void Function()? onPressed,
    IconData? icon,
    bool? inProgress,
    double? iconSize,
    Color? iconColor,
  }) {
    final disabled = inProgress == true || onPressed == null;
    final bgColor = Theme.of(context).canvasColor;
    return IconButton(
      style: isTransparent
          ? IconButton.styleFrom(
              elevation: 3,
              shadowColor: Theme.of(context).shadowColor,
              backgroundColor: bgColor,
              disabledBackgroundColor: bgColor,
            )
          : null,
      iconSize: iconSize ?? 24,
      color: iconColor,
      disabledColor: iconColor,
      icon: inProgress == true
          ? SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          : Icon(icon),
      onPressed: disabled ? null : onPressed,
    );
  }
}
