import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  final String text;
  final String link;
  const CheckBox({super.key, required this.text, required this.link});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected = !_isSelected;
                });
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFFA8A8A8))),
                child: _isSelected
                    ? const Icon(
                        Icons.check,
                        size: 17,
                        color: Colors.red,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Row(
              children: [
                Text(
                  widget.text,
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    widget.link,
                    style: const TextStyle(
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
