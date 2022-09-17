import 'package:ark_module_sertifikat/src/core/failures.dart';
import 'package:ark_module_sertifikat/src/domain/entities/sertifikat_entitiy.dart';
import 'package:ark_module_sertifikat/src/domain/repositories/sertifikat_repository.dart';
import 'package:dartz/dartz.dart';

class SertifikatUseCase {
  final SertifikatRepository repository;

  SertifikatUseCase(this.repository);

  Future<Either<Failure, SertifikatEntity>> getAllCertificate(
          String userId) async =>
      await repository.getAllCertificate(userId);
}
