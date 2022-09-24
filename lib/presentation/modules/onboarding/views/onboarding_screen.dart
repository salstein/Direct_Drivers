import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../app/utils/asset_path.dart';
import '../../../../app/utils/color_palette.dart';
import '../../../../app/utils/fonts.dart';



class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  int _current = 0;

  final List<String> imgList = [
    AssetPath.onBoardImage1,
    AssetPath.onBoardImage2,
    AssetPath.onBoardImage3,
  ];

  _onBoardingText(){
    if(_current == 0){
      return "Find Healthcare near you";
    }else if(_current == 1){
      return "Book an Appointment (Mother and Childcare)";
    }else if(_current == 2){
      return "Initiate an Emergency RED ALERT for Swift Medical Response";
    }
  }

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }


  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,10,20,30),
          child: Column(
            children: [
              SvgPicture.asset(AssetPath.splash, height: 35, width: 90,),
              const Spacer(flex: 2,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                    height: height*0.4,
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: height,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }
                      ),
                      items: imgList.map((item) => SvgPicture.asset(item, width: width, height: height, fit: BoxFit.cover,)).toList(),
                    )
                ),
              ),
              const Spacer(flex: 1,),
              _current == 2? AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: opacity1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(textAlign: TextAlign.center, text: const TextSpan(
                      text: "Initiate an Emergency ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,
                    fontFamily: AppFont.nunito, fontSize: 19,), children: [
                    TextSpan(
                        text: "RED ALERT ", style: TextStyle(color: kAlertError)
                    ),
                    TextSpan(
                        text: "for Swift Medical Response", style: TextStyle(color: Colors.black)
                    )
                  ]
                  )),
                ),
              )
                  : AnimatedOpacity(
                duration: const Duration(milliseconds: 500), opacity: opacity1,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: RichText(textAlign: TextAlign.center, text: TextSpan(
                        text: _onBoardingText(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,
                      fontFamily: AppFont.nunito, fontSize: 19,)
                    ))
                ),
              ),
              const Spacer(flex: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.map((x) {
                  int index = imgList.indexOf(x);
                  return Container(
                    width: _current == index ? 26 : 16,
                    height: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _current == index ? kPrimaryColor : kPrimaryColorLight,
                    ),
                  );
                }).toList(),
              ),
              const Spacer(flex: 1,),
              Column(
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity2,
                    child: SizedBox(height: 48, width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: kPrimaryColorLight,
                              onPrimary: kPrimaryColor,
                              elevation: 0
                          ),
                          child: const Text("Sign In", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),),
                          onPressed: (){
                            Get.toNamed(Routes.login);
                          },
                        )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity3,
                    child: SizedBox(height: 48, width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 0, ),
                          child: const Text("Sign Up", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                          onPressed: (){
                            Get.toNamed(Routes.signup);
                          },
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
