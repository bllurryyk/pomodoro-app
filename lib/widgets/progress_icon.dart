import 'package:flutter/material.dart';

class ProgressIcons extends StatelessWidget {
  final int total;
  final int done;

  const ProgressIcons({super.key, required this.total, required this.done});

  @override
  Widget build(BuildContext context) {
    const doneIcon = Icon(
      Icons.circle,
      color: Colors.white,
      size: 24,
    );

    const notDoneIcon = Icon(
      Icons.circle_outlined,
      color: Colors.white,
      size: 18,
    );

    List<Icon> icons = [];

    for (int i = 0; i < total; i++) {
      if (i < done) {
        icons.add(doneIcon);
      } else {
        icons.add(notDoneIcon);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: icons,
      ),
    );
  }
}
