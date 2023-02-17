import 'dart:async';
import 'package:flutter/material.dart';

class StatefulWrapper extends StatefulWidget {
  const StatefulWrapper({
    super.key,
    this.onInit,
    this.onUpdate,
    required this.child,
  });

  final void Function()? onInit;
  final void Function()? onUpdate;
  final Widget child;

  @override
  StatefulWrapperState createState() => StatefulWrapperState();
}

class StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {
      widget.onInit?.call();
    });
  }

  @override
  void didUpdateWidget(covariant StatefulWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    Timer.run(() {
      widget.onUpdate?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
