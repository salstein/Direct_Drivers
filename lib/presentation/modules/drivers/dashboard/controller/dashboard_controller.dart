import 'dart:async';
import 'dart:developer';
import 'package:direct_drivers/app/constants/http_status/http_status.dart';
import 'package:direct_drivers/app/constants/strings/strings.dart';
import 'package:direct_drivers/data/models/trip_model.dart';
import 'package:direct_drivers/data/remote/repositories/driver_repository/trip_repository.dart';
import 'package:direct_drivers/data/remote/services/driver_services/trip_services.dart';
import 'package:direct_drivers/domain/drivers_repository/drop_off_patient_repository.dart';
import 'package:direct_drivers/domain/drivers_repository/pick_up_patient_repository.dart';
import 'package:direct_drivers/domain/drivers_repository/trip_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';
import 'package:dio/dio.dart' as dio;

class DashBoardController extends GetxController{
  final _getTrip = Get.put(GetRedAlertTrip(TripRepository(TripServices())));
  final _pickUpPatient = Get.put(PickUpPatient(TripRepository(TripServices())));
  final _dropOffPatient = Get.put(DropOffPatient(TripRepository(TripServices())));

  //Keys
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  //Initialization
  GoogleMapController? googleMapController;
  Marker? origin;
  CameraPosition? initialPosition;
  String? errorMessage;
  List<Trips> trips = <Trips>[].obs;
  double? pickUpLocationLongitude;
  double? pickUpLocationLatitude;
  double? dropOffLocationLongitude;
  double? dropOffLocationLatitude;

  Future<void> getPickUpLocationLocationCoordinate(String location) async {
    List<Location> locations = await locationFromAddress(location);
    pickUpLocationLongitude = locations.first.longitude;
    pickUpLocationLatitude = locations.first.latitude;
  }
  Future<void> getDropOffLocationLocationCoordinate(String location) async {
    List<Location> locations = await locationFromAddress(location);
    dropOffLocationLongitude = locations.first.longitude;
    dropOffLocationLatitude = locations.first.latitude;
  }



  void addMarkerTopMap(double? lat, long){
    origin = Marker(markerId: const MarkerId(Strings.origin), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(lat ?? HttpResponseStatus.initialLatitude, long ?? HttpResponseStatus.initialLongitude));
  }

  void getInitialLocationPosition(double? lat, long){
    initialPosition = CameraPosition(target: LatLng(lat ?? HttpResponseStatus.initialLatitude, long ?? HttpResponseStatus.initialLongitude),
        zoom: HttpResponseStatus.zoomValue);
  }

  ViewState<dio.Response> dropOffPatientViewState = ViewState(state: ResponseState.EMPTY);

  void _setDropOffPatientViewState(ViewState<dio.Response> viewState) {
    this.dropOffPatientViewState = viewState;
  }

  ViewState<dio.Response> pickUpPatientViewState = ViewState(state: ResponseState.EMPTY);

  void _setPickUpPatientViewState(ViewState<dio.Response> viewState) {
    this.pickUpPatientViewState = viewState;
  }


  ViewState<TripResponseData> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<TripResponseData> viewState) {
    this.viewState = viewState;
  }

  Future<void> getTrip()async{
    _setViewState(ViewState.loading());
    await _getTrip.noParamCall().then((value) async {
      if(value is DataSuccess || value.data != null) {
        _setViewState(ViewState.complete(value.data!));
        update();
      }if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error);
        }errorMessage = value.error.toString();
        update();
        _setViewState(ViewState.error(value.error.toString()));
      }}
    );
  }

  Future<void> pickUpPatient({required String tripID})async{
    await _pickUpPatient.execute(params: PickUpQueryParam(tripID)).then((value) async{
      await getTrip().whenComplete((){
        if(value is DataSuccess) {
          _setPickUpPatientViewState(ViewState.complete(value.data!));
          update();
        }
      });
      if (value is DataFailed) {
        if (kDebugMode) {
          print(value.error.toString());
        }
        errorMessage = value.error.toString();
        _setPickUpPatientViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  Future<void> dropOffPatient({required String tripID})async{
    await _dropOffPatient.execute(params: DropOffQueryParam(tripID)).then((value) async{
      await getTrip().whenComplete((){
        if(value is DataSuccess) {
          _setDropOffPatientViewState(ViewState.complete(value.data!));
          update();
        }
      });
      if (value is DataFailed) {
        if (kDebugMode) {
          print(value.error.toString());
        }
        errorMessage = value.error.toString();
        _setDropOffPatientViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  @override
  void onInit() {
    getTrip();
    Timer.periodic(Duration(minutes: 5), (timer) {
      getTrip();
      update();
    });
    super.onInit();
  }
}
