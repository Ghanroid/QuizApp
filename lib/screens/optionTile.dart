import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  late final String option, desc, correctAnswer, optionSelected;
  OptionTile(
      {required this.option,
      required this.desc,
      required this.correctAnswer,
      required this.optionSelected});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Text("${widget.option}"),
          ),
          const SizedBox(
            width: 10,
          ),
          Text("${widget.desc}")
        ],
      ),
    );
  }
}
