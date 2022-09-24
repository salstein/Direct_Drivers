import 'dart:async';
import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../app/utils/asset_path.dart';
import '../../../../data/local/local_storage.dart';
import '../../drivers/home/views/home_page.dart';
import 'onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  var _visible = true;
  late Widget _svg;
  late AnimationController animationController;
  late Animation<double> animation;

  startTime() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, ()=>initializeRoute());
  }


  Future initializeRoute() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final loggedIn = await LocalCachedData.instance.getLoginStatus();
    if (loggedIn) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.onBoarding);
    }
  }

  @override
  void initState() {
    _svg = SvgPicture.asset(AssetPath.splash);
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => setState(() {}));
    animationController.forward();
    setState(() {
      _visible = !_visible;
    });
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(width: animation.value * 250,
              height: animation.value * 100,
              decoration: const BoxDecoration(shape: BoxShape.rectangle, color: Colors.transparent,),
              child: _svg,
            ),
          ),
        )
    );
  }
}
