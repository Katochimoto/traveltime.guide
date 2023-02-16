import 'package:flutter_riverpod/flutter_riverpod.dart';

class OverviewController extends AutoDisposeNotifier<int?> {
  @override
  int? build() {
    return null;
  }

  void show(int data) {
    state = data;
  }

  void hide() {
    if (state != null) {
      state = null;
    }
  }
}

final overviewProvider =
    NotifierProvider.autoDispose<OverviewController, int?>(() {
  return OverviewController();
});
