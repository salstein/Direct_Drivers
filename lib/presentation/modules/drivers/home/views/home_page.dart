import 'dart:io';
import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:direct_drivers/presentation/modules/drivers/home/controller/home_controller.dart';
import 'package:direct_drivers/presentation/modules/drivers/notification/view/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../../app/constants/strings/strings.dart';
import '../../../../../app/utils/asset_path.dart';
import '../../../../../app/utils/color_palette.dart';
import '../../../../../app/utils/dummy_data.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/widgets/custom_drawer_icon.dart';
import '../../../../../app/widgets/home_page_drawer.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../../../onboarding/views/onboarding_screen.dart';
import '../../account/views/account_screen.dart';
import '../../dashboard/views/dashboard_screen.dart';



class HomeScreen extends StatefulWidget {
  final DrawerIndex? drawerItem;
  final Widget? screenView;
  const HomeScreen({Key? key, this.drawerItem, this.screenView}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late List<DrawerList> drawerList;
  late Widget screenView;
  late DrawerIndex drawerIndex;
  bool notSelected = true;

  @override
  void initState() {
    _setDrawerListArray();
    drawerIndex = widget.drawerItem ?? DrawerIndex.dashboard;
    screenView =  widget.screenView ?? DashBoard();
    super.initState();
  }

  void _setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.dashboard,
        labelName: 'Dashboard',
        icon: const Icon(MdiIcons.viewDashboard),
      ),
      DrawerList(
        index: DrawerIndex.notifications,
        labelName: 'Notifications',
        icon: const Icon(MdiIcons.bell),
      ),
      DrawerList(
        index: DrawerIndex.account,
        labelName: 'Account',
        icon: const Icon(MdiIcons.account),
      ),
    ];
  }

  void uploadProfilePicture(BuildContext context, HomeController controller, ImageSource source)async{
      ProgressDialogHelper().loadingState;
      await controller.onUploadProfilePicture(source);
      if(controller.viewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        Get.offAllNamed(Routes.home);
        FlushBarHelper(context, Strings.photoUploadSuccessMsg).showSuccessBar;
      }else if(controller.viewState.state == ResponseState.ERROR){
        ProgressDialogHelper().loadStateTerminated;
        FlushBarHelper(context, controller.errorMessage == Strings.emptyString ? Strings.internalServerError : Strings.errorOccurred).showErrorBar;
      }
  }

  _showImagePickerDialog(){
    showDialog(barrierDismissible: true, context: context, builder: (context){
      return GetBuilder<HomeController>(
        init: HomeController(),
          builder: (controller){
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: const Size(180, 45)),
                  onPressed: () {
                    Get.back();
                    uploadProfilePicture(context, controller, ImageSource.gallery);
                  },
                  child: const Text("Open Gallery"),),
                const SizedBox(height: 20,),
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                    uploadProfilePicture(context, controller, ImageSource.camera);
                  },
                  style: OutlinedButton.styleFrom(
                    primary: kPrimaryColor, side: const BorderSide(color: kPrimaryColor), fixedSize: const Size(180, 45),),
                  child: const Text("Take a photo"),
                ),
              ],
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
        builder: (controller){
      return Scaffold(key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: drawerIndex == DrawerIndex.dashboard ? null : AppBar(backgroundColor: Colors.white, elevation: 0, leading: InkWell(
            onTap: ()=> _scaffoldKey.currentState!.openDrawer(),
            child: Padding(padding: const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(AssetPath.menuBar, fit: BoxFit.none,),
            ))
        ),
        drawer: HomePageDrawer(
          drawerList: drawerList,
          onTapChangePhoto: ()=> _showImagePickerDialog(),
          imageUrl: controller.driverProfileData?.data?.avatar ?? DummyData.defaultImageUrl,
          onTapLogOut: (){
            Navigator.of(context).pop();
            _showAlertDialog(context);
          },
          children: List.generate(drawerList.length, (index) => inkwell(drawerList[index]),),
          driverName: "${controller.driverProfileData?.data?.firstName} ${controller.driverProfileData?.data?.lastName}",
          child: controller.isUploadingProfilePicture == true ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)
              : controller.isUploadingProfilePicture == false ? null : null,
        ),
        body: WillPopScope(
            onWillPop: _onWillPop,
            child: drawerIndex == DrawerIndex.dashboard ? Stack(
              children: [
                screenView,
                CustomAppBar(onTap: ()=> _scaffoldKey.currentState!.openDrawer(),),
              ],
            ) : screenView
        ),
      );
    });
  }

  Widget inkwell(DrawerList listData) {
    return InkWell(
      onTap: () {
        _navigationToScreen(listData.index!);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Stack(
          children: <Widget>[
            drawerIndex == listData.index ?
            Container(width: MediaQuery.of(context).size.width, height: 46,
              decoration: BoxDecoration(color: const Color(0xFFF1F5F8),
                borderRadius: BorderRadius.circular(4),
              ),
            ) : const SizedBox(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 46,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Row(
                  children: <Widget>[
                    listData.isAssetsImage ? SizedBox(width: 24, height: 24,
                      child: Image.asset(listData.imageName, color: listData.index == DrawerIndex.center ? kAlertError : drawerIndex == listData.index ? kPrimaryColor : const Color(0xFFA0A4A8)),)
                        : Icon(listData.icon?.icon, size: 19, color: drawerIndex == listData.index ? kPrimaryColor : const Color(0xFFA0A4A8)
                    ),
                    const SizedBox(width: 16,),
                    Expanded(
                      child: Text(listData.labelName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,
                        color: drawerIndex == listData.index ? kPrimaryColor : const Color(0xFFA0A4A8),
                      ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigationToScreen(DrawerIndex indexScreen) async {
    Get.back();
    if (drawerIndex != indexScreen) {
      notSelected = true;
      drawerIndex = indexScreen;
      if (drawerIndex == DrawerIndex.dashboard) {
        setState(() {
          screenView = DashBoard();
        });
      } else if (drawerIndex == DrawerIndex.notifications) {
        setState(() {
          screenView = const NotificationScreen();
        });
      }
      else if (drawerIndex == DrawerIndex.account) {
        setState(() {
          screenView = const Account();
        });
      }
    }
  }

  Widget cancelButton(){
    return TextButton(
      child: const Text("No", style: TextStyle(color: kPrimaryColor)),
      onPressed:  () {
        Get.back();
      },
    );
  }

  Future initializeRoute() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: false);
    Get.back();
    Get.offUntil(GetPageRoute(page: ()=> const OnBoardingScreen()), (Route<dynamic> route) => false);
  }

  Widget continueButton(){
    return  TextButton(
      child: const Text("Yes", style: TextStyle(color: kPrimaryColor),),
      onPressed:  ()=> initializeRoute(),
    );
  }

  _showAlertDialog(BuildContext context) {

    AlertDialog alert = AlertDialog(
      content: const Text("Are you sure"),
      actions: [
        cancelButton(),
        continueButton(),
      ],
    );
    showDialog(
      context: context, builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> _onWillPop() async {
    Widget cancelButton = TextButton(
      child: const Text("NO", style: TextStyle(color: kPrimaryColor),),
      onPressed:  () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("YES", style: TextStyle(color: kPrimaryColor),),
      onPressed:  () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
    );

    AlertDialog alert = AlertDialog(
      content: const Text("Do you want to exit app?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return (await showDialog(
      context: context,
      builder: (context) => alert,
    )) ?? false;
  }

}

enum DrawerIndex {
  dashboard,
  center,
  myPatients,
  doctors,
  teamMembers,
  report,
  notifications,
  account,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
