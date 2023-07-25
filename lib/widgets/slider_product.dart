import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:traveltime/constants/_theme.dart';

class ProductCarousel extends StatefulWidget {
  final List<dynamic> imgArray;

  const ProductCarousel({
    Key? key,
    required this.imgArray,
  }) : super(key: key);

  @override
  ProductCarouselState createState() => ProductCarouselState();
}

class ProductCarouselState extends State<ProductCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.imgArray
          .map((item) => Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).shadowColor,
                              blurRadius: 5,
                              spreadRadius: 0.3,
                              offset: const Offset(0, 2))
                        ]),
                        child: AspectRatio(
                          aspectRatio: 2 / 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              item["img"],
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: UIGap.g3),
                      child: Column(
                        children: [
                          Text(item["price"],
                              style: Theme.of(context).textTheme.displayMedium),
                          Text(item["title"],
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          const SizedBox(height: UIGap.g1),
                          Text(
                            item["description"],
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
          .toList(),
      options: CarouselOptions(
          height: 530,
          autoPlay: false,
          enlargeCenterPage: false,
          aspectRatio: 4 / 4,
          enableInfiniteScroll: false,
          initialPage: 0,
          // viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
    );
  }
}
