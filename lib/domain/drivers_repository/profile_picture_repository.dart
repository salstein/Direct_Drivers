import 'package:direct_drivers/core/use_cases/use_cases.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../app/constants/strings/strings.dart';
import '../../data/remote/dio/dio_data_state.dart';
import '../../data/remote/dio/dio_error_handling.dart';
import '../../data/remote/repositories/driver_repository/update_profile_repository.dart';


class UploadProfilePicture extends useCase<DataState<Response>, Param>{
  final UpdateProfileRepository _uploadProfilePictureRepository;
  UploadProfilePicture(this._uploadProfilePictureRepository);

  @override
  Future<DataState<Response>> execute({required Param params}) async{
    try {
      final response = await _uploadProfilePictureRepository.uploadProfilePicture(imageFile: params.imageFile);
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

class Param{
  final XFile? imageFile;
  Param(this.imageFile);
}