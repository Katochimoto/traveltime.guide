import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

enum PopoverType {
  marker,
  cluster,
}

class PopoverData {
  final PopoverType? type;
  final Bounds? bounds;
  final LatLng? point;
  final List<int?>? pointIds;

  const PopoverData({
    this.bounds,
    this.point,
    this.type = PopoverType.marker,
    this.pointIds,
  });

  factory PopoverData.empty() {
    return const PopoverData();
  }
}

class PopoverDataController extends Notifier<PopoverData> {
  @override
  PopoverData build() {
    return PopoverData.empty();
  }

  void show(PopoverData data) {
    state = data;
  }

  void hide() {
    if (state.bounds != null) {
      state = PopoverData.empty();
    }
  }
}

final popoverProvider =
    NotifierProvider<PopoverDataController, PopoverData>(() {
  return PopoverDataController();
});
