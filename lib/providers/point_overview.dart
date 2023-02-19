import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/store/models/point.dart';

class OverviewData {
  final Point point;
  final bool animation;

  const OverviewData({
    required this.point,
    this.animation = false,
  });
}

class OverviewController extends AutoDisposeNotifier<OverviewData?> {
  @override
  OverviewData? build() {
    return null;
  }

  void show(OverviewData data) {
    state = data;
  }

  void hide() {
    if (state != null) {
      state = null;
    }
  }
}

final overviewProvider =
    NotifierProvider.autoDispose<OverviewController, OverviewData?>(() {
  return OverviewController();
});
