import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:direct_drivers/presentation/modules/auth/verifcation/views/driver_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../auth/verifcation/controller/verification_controller.dart';
import '../../password_reset/view/update_password_screen.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24,20,24,30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          const SizedBox(height: 36,),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.profile);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),color: const Color(0xFFF8F8F8)),
                        child: const ListTile(
                          leading: Icon(MdiIcons.account, size: 20, color: Color(0xFF52575C)),
                          title: Text("Profile", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          trailing: Icon(Icons.arrow_forward_ios, size: 13, color: Colors.black,),
                          horizontalTitleGap: 0,
                          minLeadingWidth: 33,
                        )
                    ),
                  ),
                  const SizedBox(height: 14,),
                  InkWell(
                    onTap: (){
                      Get.to(()=>const UpdatePassword());
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xFFF8F8F8)
                        ),
                        child: const ListTile(
                          leading: Icon(Icons.lock, size: 20, color: Color(0xFF52575C)),
                          title: Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          trailing: Icon(Icons.arrow_forward_ios, size: 13, color: Colors.black,),
                          horizontalTitleGap: 0,
                          minLeadingWidth: 33,
                        )
                    ),
                  ),
                  const SizedBox(height: 14,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.driverVerification, arguments: Routes.account);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0xFFF8F8F8)),
                        child: const ListTile(
                          leading: Icon(MdiIcons.accountCheck, size: 20, color: Color(0xFF52575C)),
                          title: Text("Verification Information", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          trailing: Icon(Icons.arrow_forward_ios, size: 13, color: Colors.black,),
                          horizontalTitleGap: 0,
                          minLeadingWidth: 33,
                        )
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
