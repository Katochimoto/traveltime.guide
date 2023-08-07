import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class OSMTileLayer extends StatelessWidget {
  const OSMTileLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: const ['a', 'b', 'c'],
      userAgentPackageName: 'guide.traveltime.app',
      retinaMode: false, // MediaQuery.of(context).devicePixelRatio > 1.0,
      minZoom: 3,
      maxZoom: 18,
      // maybe https://github.com/flutter/packages/tree/main/packages/flutter_image
      tileProvider: NetworkTileProvider(),
      errorImage: const AssetImage('assets/imgs/empty_tile.png'),
      // backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
    );
  }
}
