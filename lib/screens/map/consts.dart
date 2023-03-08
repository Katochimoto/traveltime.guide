import 'dart:math';
import 'package:flutter/material.dart';
import 'package:traveltime/store/models/point.dart';

const markerSize = 30.0;
const clusterSize = 40.0;

const defaultMarkerColor = Colors.teal;
const defaultMarkerIcon = Icons.location_on;

final markerColors = {
  PointCategory.entertainment: Colors.teal,
  PointCategory.event: Colors.deepPurple,
  PointCategory.attraction: Colors.green,
  PointCategory.nightMarket: Colors.lightBlue,
  PointCategory.hypermarket: Colors.lightBlue,
  PointCategory.beach: Colors.yellow,
  PointCategory.restaurant: Colors.orange,
  PointCategory.cafe: Colors.orange,
  PointCategory.marina: Colors.cyan,
  PointCategory.police: Colors.blueGrey,
  PointCategory.gasStation: Colors.brown,
  PointCategory.carRental: Colors.brown,
  PointCategory.hotel: Colors.pink,
};

final markerIcons = {
  PointCategory.entertainment: Icons.local_activity,
  PointCategory.event: Icons.event,
  PointCategory.attraction: Icons.attractions,
  PointCategory.nightMarket: Icons.local_grocery_store,
  PointCategory.hypermarket: Icons.local_mall,
  PointCategory.beach: Icons.beach_access,
  PointCategory.restaurant: Icons.local_restaurant,
  PointCategory.cafe: Icons.local_cafe,
  PointCategory.marina: Icons.directions_ferry,
  PointCategory.police: Icons.local_police,
  PointCategory.gasStation: Icons.local_gas_station,
  PointCategory.carRental: Icons.car_rental,
  PointCategory.hotel: Icons.local_hotel,
};

Paint markerFillPaintFactory(Color color) => Paint()
  ..color = color
  ..style = PaintingStyle.fill;

Paint markerShadowPaintFactory(Color color) => Paint()
  ..color = color
  ..maskFilter = MaskFilter.blur(BlurStyle.normal, sqrt(5));

final defaultMarkerFillPaint = markerFillPaintFactory(defaultMarkerColor);
final defaultMarkerShadowPaint = markerShadowPaintFactory(defaultMarkerColor);

final markerFillPaint = {
  for (var item in PointCategory.values)
    item: markerFillPaintFactory(markerColors[item] ?? defaultMarkerColor),
};

final markerShadowPaint = {
  for (var item in PointCategory.values)
    item: markerShadowPaintFactory(markerColors[item] ?? defaultMarkerColor),
};

final markerStrokePaint = Paint()
  ..color = Colors.white
  ..style = PaintingStyle.stroke
  ..strokeWidth = 2
  ..strokeCap = StrokeCap.round;

final arrowPaint = Paint()
  ..strokeWidth = 2.0
  ..color = Colors.white
  ..style = PaintingStyle.fill;

final clusterFillPaint = Paint()
  ..color = Colors.white
  ..style = PaintingStyle.fill;
