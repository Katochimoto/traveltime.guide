import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TapPosition {
  Offset? offset;

  TapPosition({this.offset});

  factory TapPosition.empty() {
    return TapPosition();
  }
}

class MapTapPosition extends Notifier<TapPosition> {
  @override
  TapPosition build() {
    return TapPosition.empty();
  }

  void updatePosition(TapPosition data) {
    state = data;
  }

  void hide() {
    if (state.offset != null) {
      state = TapPosition.empty();
    }
  }

  void tap(Offset offset) {
    if (state.offset != offset) {
      state = TapPosition(offset: offset);
    }
  }
}

final mapTapPositionProvider =
    NotifierProvider<MapTapPosition, TapPosition>(() {
  return MapTapPosition();
});
