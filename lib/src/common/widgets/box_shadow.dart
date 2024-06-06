import 'package:flutter/material.dart';

/// Corporative `BoxShadow` widget
class CBoxShadow extends StatelessWidget {
  const CBoxShadow({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            color: Color.fromARGB(34, 182, 161, 192),
            offset: Offset(2, 4),
            blurRadius: 10)
      ]),
      child: child,
    );
  }
}
