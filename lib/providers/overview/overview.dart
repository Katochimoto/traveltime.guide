import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/store/models.dart' as models;

class OverviewData {
  final models.MapObject object;
  final bool animation;

  const OverviewData({
    required this.object,
    this.animation = false,
  });
}

class OverviewController extends Notifier<OverviewData?> {
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
    NotifierProvider<OverviewController, OverviewData?>(() {
  return OverviewController();
});
