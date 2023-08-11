import 'package:flutter/material.dart';
import 'package:traveltime/store/models.dart' as models;

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.eventCategoryColor,
    required this.eventCategoryDeepColor,
  });

  final Map<models.EventCategory, Color?> eventCategoryColor;
  final Map<models.EventCategory, Color?> eventCategoryDeepColor;

  @override
  CustomColors copyWith({
    Map<models.EventCategory, Color?>? eventCategoryColor,
    Map<models.EventCategory, Color?>? eventCategoryDeepColor,
  }) {
    return CustomColors(
      eventCategoryColor: eventCategoryColor ?? this.eventCategoryColor,
      eventCategoryDeepColor:
          eventCategoryDeepColor ?? this.eventCategoryDeepColor,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    return this;
  }
}
