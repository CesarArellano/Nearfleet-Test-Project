import 'package:flutter/material.dart';

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( right: 10 ),
      color: Colors.red[400],
      alignment: Alignment.centerRight,
      child: const Icon( Icons.delete_outline_rounded, color: Colors.white ),
    );
  }
}