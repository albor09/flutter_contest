import 'dart:ui';
import 'package:flutter/material.dart';

/// Corporative `Slider` widget
class CSlider extends StatefulWidget {
  const CSlider(
      {required this.value,
      required this.onChange,
      this.fromText,
      this.toText,
      this.anchors = const [],
      super.key});

  final double value;

  final String? fromText;
  final String? toText;

  final List<double> anchors;

  final void Function(double value) onChange;

  @override
  State<CSlider> createState() => _CSliderState();
}

class _CSliderState extends State<CSlider> {
  double anchored(double value) {
    for (var anchor in widget.anchors) {
      if ((value - anchor).abs() < 0.025) return anchor;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(34, 182, 161, 192),
                offset: Offset(2, 4),
                blurRadius: 10)
          ]),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (details) => widget.onChange(clampDouble(
                anchored(details.localPosition.dx / constraints.maxWidth),
                0,
                1)),
            onPanUpdate: (details) => widget.onChange(clampDouble(
                anchored(details.localPosition.dx / constraints.maxWidth),
                0,
                1)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      6,
                      (index) => Container(
                            height: 8,
                            width: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE1DDD8),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE1DDD8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 6,
                      ),
                      Positioned.fromRect(
                          rect: Rect.fromLTWH(
                              0, 0, constraints.maxWidth * widget.value, 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          )),
                      Positioned.fromRect(
                        rect: Rect.fromLTWH(
                            constraints.maxWidth * widget.value - 9,
                            -6,
                            18,
                            18),
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              color: primary),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.fromText ?? '',
                      style: const TextStyle(color: Color(0xFFBCBCBF)),
                    ),
                    Text(widget.toText ?? '',
                        style: const TextStyle(color: Color(0xFFBCBCBF))),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
