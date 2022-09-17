import 'package:ark_module_sertifikat/src/data/dto/sertifikat_dto.dart';

abstract class SertifikatRemoteDataSource {
  Future<SertifikatDTO> getAllCertificate(String userId);
}
