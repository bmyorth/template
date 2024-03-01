import 'package:flutter/material.dart';
//-------------------------------

// ignore: must_be_immutable
class CheckBoxApp extends StatefulWidget {
  final Function? onChange;
  bool? isChecked;
  final Color? selectedColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final bool? rounded;
  final bool disabled;

  CheckBoxApp(
      {super.key,
      this.isChecked = false,
      this.onChange,
      this.selectedColor = Colors.black87,
      this.borderColor = Colors.black87,
      this.rounded = false,
      this.backgroundColor,
      this.disabled = false});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CheckBoxApp> {
  @override
  Widget build(BuildContext context) {
    return widget.disabled
        ? Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius:
                    BorderRadius.circular(widget.rounded! ? 20.0 : 5.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                )),
            width: 24.0,
            height: 24.0,
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                widget.isChecked = !widget.isChecked!;
                widget.onChange?.call(widget.isChecked);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: widget.isChecked! && widget.backgroundColor != null
                      ? widget.backgroundColor
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(widget.rounded! ? 20.0 : 5.0),
                  border: Border.all(
                    color: widget.isChecked! && widget.backgroundColor != null
                        ? widget.backgroundColor!
                        : widget.borderColor!,
                    width: 2.0,
                  )),
              width: 24.0,
              height: 24.0,
              child: widget.isChecked!
                  ? Icon(
                      Icons.check,
                      color: widget.selectedColor,
                      size: 20,
                    )
                  : null,
            ),
          );
  }
}
