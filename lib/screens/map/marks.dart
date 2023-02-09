import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Marks extends ConsumerWidget {
  const Marks({super.key, this.sc, this.padding});

  final ScrollController? sc;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      controller: sc,
      physics: const BouncingScrollPhysics(),
      padding: padding,
      itemBuilder: (_, idx) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)))),
            child: SizedBox(
              height: 50,
              child: Row(children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    // border: Border.all(color: Colors.black45, width: 2),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          'https://via.placeholder.com/200'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'asd',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ]),
            ),
          ),
        );
      },
      itemCount: 100,
    );
  }
}
