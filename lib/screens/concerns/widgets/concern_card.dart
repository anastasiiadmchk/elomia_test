import 'package:elomia_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ConcernCard extends StatefulWidget {
  const ConcernCard(
      {Key? key,
      required this.title,
      this.subtitle,
      required this.onSelect,
      required this.selected})
      : super(key: key);
  final String title;
  final String? subtitle;
  final Function(bool?) onSelect;
  final bool selected;

  @override
  _ConcernCardState createState() => _ConcernCardState();
}

class _ConcernCardState extends State<ConcernCard> {
  bool selected = false;
  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      decoration: BoxDecoration(
        color: ElomiaTheme.mazarine,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            width: selected ? 2 : 1,
            color: selected ? ElomiaTheme.blue : ElomiaTheme.lightMazarine),
      ),
      margin: const EdgeInsets.only(
        left: 32.0,
        right: 32,
        bottom: 16,
      ),
      child: GFCheckboxListTile(
        value: selected,
        onChanged: (newValue) {
            widget.onSelect(newValue);
            setState(() {
              selected = newValue;
            });
        },
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16),
        ),
        subTitle: widget.subtitle != null
            ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  widget.subtitle!,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 13),
                ),
              )
            : null,
        position: GFPosition.start,
        activeBorderColor: ElomiaTheme.blue,
        type: GFCheckboxType.circle,
        activeBgColor: ElomiaTheme.blue,
        inactiveBgColor: ElomiaTheme.mazarine,
        inactiveBorderColor: ElomiaTheme.lightMazarine,
        size: 22,
        activeIcon: const Icon(
          Icons.check,
          size: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}

