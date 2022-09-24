import 'package:flutter/material.dart';
import '../../presentation/modules/drivers/home/views/home_page.dart';
import '../utils/color_palette.dart';


class HomePageDrawer extends StatelessWidget {
  final void Function()? onTapChangePhoto;
  final void Function()? onTapLogOut;
  final String? imageUrl;
  final List<Widget> children;
  final List<DrawerList> drawerList;
  final String? driverName;
  final Widget? child;
  const HomePageDrawer({ this.onTapChangePhoto, this.imageUrl, this.onTapLogOut, required this.drawerList, required this.children, this.driverName, this.child});

  @override
  Widget build(BuildContext context) {
    return Drawer(width: MediaQuery.of(context).size.width/1.5,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24,24,24,24),
          child: SizedBox(
            width: double.maxFinite, height: double.maxFinite,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(height: 48, width: 48,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.15),
                        image: DecorationImage(image: NetworkImage(imageUrl!),
                          fit: BoxFit.cover,
                        )
                    ),
                    child: child,
                  ),
                  const SizedBox(width: 14,),
                  Expanded(
                    child: InkWell(
                      onTap: onTapChangePhoto,
                      child: const Text("Change Photo", style: TextStyle(color: kPrimaryColor,
                          decoration: TextDecoration.underline, fontSize: 15, fontWeight: FontWeight.bold),),),)
                ],
                ),
                const SizedBox(height: 24,),
                Text(driverName ?? "", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16,),),
                const SizedBox(height: 16,),
                const Divider(thickness: 1.1, height: 1, color: Color(0xFFC4C4C4),),
                const SizedBox(height: 26,),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Column(
                            children: children
                        ),
                        InkWell(
                          onTap: onTapLogOut,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 11, top: 11),
                            child: Row(
                              children: const [
                                Icon(Icons.power_settings_new_rounded, size: 19, color:  Color(0xFFA0A4A8)),
                                SizedBox(width: 16,),
                                Expanded(
                                  child: Text("Logout", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,
                                    color: Color(0xFFA0A4A8),), textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
