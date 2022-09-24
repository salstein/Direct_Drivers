import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60,),
        Center(child: Container(
          height: 90,
          width: 90,
          color: Colors.transparent,
          child: CircularProgressIndicator(strokeWidth: 0.9,color: Theme.of(context).primaryColor,),
        ),),
        SizedBox(height: 8,),
        Text("An Error Occurred", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Color(0xFF52575C), fontSize: 15),)
      ],
    );
  }
}