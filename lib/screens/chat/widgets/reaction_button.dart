import 'package:elomia_test/network/network.dart';
import 'package:elomia_test/theme/theme.dart';
import 'package:flutter/material.dart';

class ReactionButton extends StatefulWidget {
  const ReactionButton(
      {Key? key,
      required this.reaction,
      required this.color,
      required this.onPressed})
      : super(key: key);

  final Reaction reaction;
  final Color color;
  final Color? Function() onPressed;

  @override
  _ReactionButtonState createState() => _ReactionButtonState();
}

class _ReactionButtonState extends State<ReactionButton> {
  Color? currentColor;
  @override
  void initState() {
    super.initState();
    currentColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: ElevatedButton(
        onPressed: (() {
          currentColor = widget.onPressed();
          setState(() {});
        }),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 3,
          shape: const CircleBorder(side: BorderSide.none),
          primary: ElomiaTheme.darkWhite,
        ),
        child: Icon(
          widget.reaction == Reaction.like
              ? Icons.thumb_up_alt_rounded
              : Icons.thumb_down_alt_rounded,
          size: 18,
          color: currentColor ?? ElomiaTheme.lightGrey,
        ),
      ),
    );
  }
}
