import 'package:flutter/material.dart';

class DropController extends ChangeNotifier {
  AnimationController _controller;

  DropController({required TickerProvider vsync})
      : _controller = AnimationController(
          vsync: vsync,
          duration: Duration(seconds: 2),
        ) {
    _controller.repeat(reverse: true);
  }

  double get value => _controller.value;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
