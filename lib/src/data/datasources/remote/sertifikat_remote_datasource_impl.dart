import 'dart:developer';
import 'package:ark_module_sertifikat/src/core/exception.dart';
import 'package:ark_module_sertifikat/src/data/datasources/remote/sertifikat_remote_datasource.dart';
import 'package:ark_module_sertifikat/src/data/dto/sertifikat_dto.dart';
import 'package:ark_module_sertifikat/utils/app_url.dart';
import 'package:dio/dio.dart';

class SertifikatRemoteDataSourceImpl implements SertifikatRemoteDataSource {
  late Dio dio;
  SertifikatRemoteDataSourceImpl({Dio? dio}) {
    this.dio = dio ?? Dio();
  }

  @override
  Future<SertifikatDTO> getAllCertificate(String userId) async {
    final response = await dio.get("$sertifUrl/$userId");
    log("RESPONSE GET ALL CERTIFICATE : ${response.data}");
    log("RESPONSE GET ALL CERTIFICATE : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code >= 500) {
      throw CustomException(code, 'Error... failed connect to server');
    } else if (code != 200) {
      throw CustomException(
          code, response.data['message'] ?? 'Failed... Please try again');
    } else {
      return SertifikatDTO.fromJson(response.data);
    }
  }
}
