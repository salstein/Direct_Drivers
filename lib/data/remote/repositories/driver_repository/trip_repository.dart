import 'package:direct_drivers/data/remote/services/driver_services/trip_services.dart';
import 'package:dio/dio.dart';

class TripRepository{
  final TripServices _tripServices;
  TripRepository(this._tripServices);
  Future<Response> getTrip() => _tripServices.getTrip();
  Future<Response> pickUpPatient({required String tripID}) => _tripServices.pickUpPatient(tripID: tripID);
  Future<Response> dropOffPatient({required String tripID}) => _tripServices.dropOffPatient(tripID: tripID);
}