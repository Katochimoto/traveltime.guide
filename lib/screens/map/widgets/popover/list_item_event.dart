import 'package:flutter/material.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/store/models.dart' as models;

class ListItemEvent extends StatelessWidget {
  const ListItemEvent({super.key, required this.event, this.onTap});

  final models.Event event;
  final void Function(models.Event event)? onTap;

  @override
  Widget build(BuildContext context) {
    final instance = event.actualInstanceFrom(DateTime.now());
    const height = 60.0;
    return ElevatedButton(
      onPressed: onTap != null ? () => onTap?.call(event) : null,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(UIGap.g3)))),
      child: SizedBox(
        height: height,
        child: Row(children: [
          if (event.logoImg != null)
            Container(
              width: height,
              height: height,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(UIGap.g3)),
              ),
              child: Image.network(
                event.logoImg!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return child;
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.image_not_supported_outlined, size: 20),
                  );
                },
              ),
            ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: UIGap.g1, horizontal: UIGap.g2),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            event.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        if (instance != null)
                          Padding(
                            padding: const EdgeInsets.only(left: UIGap.g1),
                            child: Text(
                              instance.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      event.intro ?? event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
