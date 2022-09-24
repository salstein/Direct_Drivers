import 'package:direct_drivers/app/utils/color_palette.dart';
import 'package:direct_drivers/app/widgets/loading_widget.dart';
import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:direct_drivers/core/state/view_state.dart';
import 'package:direct_drivers/presentation/modules/drivers/dashboard/controller/dashboard_controller.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import '../../../../../app/constants/strings/strings.dart';
import '../../../../../app/utils/asset_path.dart';
import '../../../../../app/utils/dummy_data.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/widgets/custom_map_bottom_sheet.dart';
import '../../../../../app/widgets/empty_screen.dart';
import '../../../../../app/widgets/error_screen.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  Widget buildTripScreen(DashBoardController controller){
    switch (controller.viewState.state){
      case ResponseState.LOADING:
        return LoadingWidget(loadingMessage: Strings.loadingTrip,);
      case ResponseState.COMPLETE:
        final items = controller.viewState.data;
        return Column(
          children: [
            ...List.generate(items!.data!.length, (index){
              controller.getPickUpLocationLocationCoordinate("${items.data![index].pickupAddress}");
              controller.getDropOffLocationLocationCoordinate("${items.data![index].dropOfAddress}");
              final Distance distance = Distance();
             final  km = distance.as(LengthUnit.Kilometer, LatLng(controller.pickUpLocationLatitude ?? 52.518611, controller.pickUpLocationLongitude ?? 13.408056),
                  LatLng(controller.dropOffLocationLatitude ?? 51.519475, controller.dropOffLocationLongitude ?? 7.46694444));
              return Column(
                children: [
                  Row(
                    children: [
                      Container(height: 48, width: 48,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(fit: BoxFit.fill,
                                image: NetworkImage(items.data![index].redAlert!.patient!.avatar ?? DummyData.defaultImageUrl)
                            )
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${items.data![index].redAlert!.patient!.firstName} ${items.data![index].redAlert!.patient!.lastName}",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 2,),
                            Text("${km.toInt()} ${Strings.kmMsg}", style: const TextStyle(fontSize: 12, color: Color(0xFF878A8D), fontWeight: FontWeight.bold),)
                          ],
                        ),
                      )),
                      Row(
                        children: [
                          Container(height: 10, width: 10,
                            decoration: BoxDecoration(color: items.data![index].status == Strings.pending ? Colors.redAccent :
                            items.data![index].status == Strings.onTransit ? Colors.yellow :
                            items.data![index].status == Strings.completed ? Colors.green :
                            Colors.transparent, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 3,),
                          Text("${items.data![index].status}",
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AssetPath.location),
                      const SizedBox(width: 20,),
                      Expanded(child: Text("${items.data![index].pickupAddress}", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),)),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AssetPath.destination),
                      const SizedBox(width: 20,),
                      Expanded(child: Text("${items.data![index].dropOfAddress ?? Strings.noAddressSpecified}",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),)),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(height: 48, width: double.maxFinite,
                    child: ElevatedButton(onPressed: (){
                      items.data![index].status == Strings.pending ? pickUpPatient(context, controller, tripID: items.data![index].uuid) : null;
                    },
                      style: ElevatedButton.styleFrom(elevation: 0, primary: items.data![index].status == Strings.pending ? kPrimaryColor : Colors.grey),
                      child: const Text(Strings.pickUpPatient, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(height: 48, width: double.maxFinite,
                    child: ElevatedButton(onPressed: (){
                      items.data![index].status == Strings.onTransit ? dropOffPatient(context, controller, tripID: items.data![index].uuid) : null;
                    },
                      style: ElevatedButton.styleFrom(elevation: 0, primary: items.data![index].status == Strings.onTransit ? Colors.green : Colors.grey),
                      child: const Text(Strings.dropOffPatient, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  const SizedBox(height: 30,),
                ],
              );
            })
          ],
        );
      case ResponseState.ERROR:
        return const ErrorScreen();
      case ResponseState.EMPTY:
        return const EmptyScreen();
    }
  }

  void pickUpPatient(BuildContext context, DashBoardController controller,{required String? tripID})async{
    ProgressDialogHelper().loadingState;
    await controller.pickUpPatient(tripID: tripID!);
    if(controller.pickUpPatientViewState.state == ResponseState.COMPLETE){
      ProgressDialogHelper().loadStateTerminated;
      Get.offAllNamed(Routes.home);
      FlushBarHelper(context, Strings.notified).showSuccessBar;
    }else if(controller.pickUpPatientViewState.state == ResponseState.ERROR){
      ProgressDialogHelper().loadStateTerminated;
      FlushBarHelper(context, controller.errorMessage == Strings.emptyString ? Strings.internalServerError : Strings.errorOccurred).showErrorBar;
    }
  }

  void dropOffPatient(BuildContext context, DashBoardController controller,{required String? tripID})async{
    ProgressDialogHelper().loadingState;
    await controller.dropOffPatient(tripID: tripID!);
    if(controller.dropOffPatientViewState.state == ResponseState.COMPLETE){
      ProgressDialogHelper().loadStateTerminated;
      Get.offAllNamed(Routes.home);
      FlushBarHelper(context, Strings.dropOff).showSuccessBar;
    }else if(controller.dropOffPatientViewState.state == ResponseState.ERROR){
      ProgressDialogHelper().loadStateTerminated;
      FlushBarHelper(context, controller.errorMessage == Strings.emptyString ? Strings.internalServerError : Strings.errorOccurred).showErrorBar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      init: DashBoardController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            key: controller.scaffoldKey,
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Positioned(top: 0, left: 0, right: 0,
                  height: MediaQuery.of(context).size.height,
                  child: maps.GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: true,
                    compassEnabled: false,
                    myLocationEnabled: true,
                    mapType: maps.MapType.normal,
                    initialCameraPosition: controller.initialPosition!,
                    onMapCreated: (mapController) => controller.googleMapController = mapController,
                    markers: {
                      controller.origin!,
                    },
                  ),
                ),
                CustomMapBottomSheet(
                  children: [
                    SizedBox(height: 25,),
                    Text(Strings.newRequest, style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),),
                    SizedBox(height: 25,),
                    buildTripScreen(controller),
                  ],),
              ],
            ),
          )
      );
    });
  }
}
