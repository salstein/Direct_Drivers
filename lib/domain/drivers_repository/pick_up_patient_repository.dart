

import 'package:direct_drivers/data/remote/repositories/driver_repository/trip_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../app/constants/strings/strings.dart';
import '../../core/use_cases/use_cases.dart';
import '../../data/remote/dio/dio_data_state.dart';
import '../../data/remote/dio/dio_error_handling.dart';

class PickUpPatient implements useCase<DataState<Response>, PickUpQueryParam> {
  final TripRepository _tripRepository;

  PickUpPatient(this._tripRepository);

  @override
  Future<DataState<Response>> execute({required PickUpQueryParam params}) async{
    try {
      final response = await _tripRepository.pickUpPatient(tripID: params.tripId!);
      if (response.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {;
      return DataSuccess(response);
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      if (kDebugMode) {
        print(errorMessage);
      }
      return DataFailed(err.response?.data[Strings.error].toString() ?? errorMessage);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return DataFailed(err.toString());
    }
  }
}

class PickUpQueryParam{
  final String? tripId;
  PickUpQueryParam(this.tripId);
}