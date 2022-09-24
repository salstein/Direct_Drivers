import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/utils/terms_and_condition.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
          Get.back();
        },),),
        body: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Terms & Conditions", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
                  const SizedBox(height: 36,),
                  ...List.generate(kTerms.length, (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${index+1}. ${kTerms[index]['heading']}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                      const SizedBox(height: 15,),
                      Text("${kTerms[index]['data']}", textAlign: TextAlign.justify, style: const TextStyle(color: Colors.black, fontSize: 14),),
                      const SizedBox(height: 24,),
                    ],
                  )),
                  const SizedBox(height: 36,),
                  const Text("PRIVACY POLICY", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
                  const SizedBox(height: 36,),
                  ...List.generate(kPrivacy.length, (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${index+1}. ${kPrivacy[index]['heading']}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                      const SizedBox(height: 15,),
                      Text("${kPrivacy[index]['data']}", textAlign: TextAlign.justify, style: const TextStyle(color: Colors.black, fontSize: 14),),
                      const SizedBox(height: 24,),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
