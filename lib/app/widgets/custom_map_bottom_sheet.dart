import 'package:flutter/material.dart';
class CustomMapBottomSheet extends StatelessWidget {
  final List<Widget> children;
  const CustomMapBottomSheet({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.42,
        maxChildSize: 0.9,
        minChildSize: 0.42,
        builder: (BuildContext context, ScrollController controller){
          return Container(
            decoration: const BoxDecoration(color: Colors.white,  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),)
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: controller,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  )
              ),
            ),
          );
        });
  }
}
