import 'package:flutter/material.dart';
import '../utils/color_palette.dart';

class DropDownField extends StatelessWidget {
  final void Function()? onPressed;
  final Widget label;
  final Widget? icon;
  const DropDownField({Key? key, this.onPressed, required this.label, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: kGrayScale1),
      height: 50, width: double.maxFinite,
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              label,
              icon ?? const Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 14,)
            ],
          ),
        ),
      ),
    );
  }
}
