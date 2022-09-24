import 'package:dio/dio.dart';
import 'package:direct_drivers/data/models/trip_model.dart';
import 'package:direct_drivers/data/remote/repositories/driver_repository/trip_repository.dart';
import 'package:flutter/foundation.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../app/constants/strings/strings.dart';
import '../../core/use_cases/use_cases.dart';
import '../../data/remote/dio/dio_data_state.dart';
import '../../data/remote/dio/dio_error_handling.dart';

class GetRedAlertTrip implements noParamUseCases<DataState<TripResponseData>> {
  final TripRepository _tripRepository;
  GetRedAlertTrip(this._tripRepository);

  Future<DataState<TripResponseData>> noParamCall() async{
    try {
      final response = await _tripRepository.getTrip();
      if (response.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {;
      return DataSuccess(TripResponseData.fromJson(response.data));
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