import 'package:flutter/material.dart';
import '../utils/color_palette.dart';

class DropDownMenuWidget extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final void Function(String?)? onChanged;
  final String? value;
  final Widget? icon;
  const DropDownMenuWidget({Key? key, required this.items, this.onChanged, this.value, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: kGrayScale1, borderRadius: BorderRadius.circular(5),),
      height: 50, width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isDense: true, isExpanded: true,
            value: value,
            icon:  icon ?? const Icon(Icons.keyboard_arrow_down, color: Colors.black,size: 14,),
            onChanged: onChanged,
            items: items,
          ),
        ),
      ),
    );
  }
}
