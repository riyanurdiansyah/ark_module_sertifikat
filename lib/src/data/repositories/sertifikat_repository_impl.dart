import 'package:ark_module_sertifikat/src/core/exception.dart';
import 'package:ark_module_sertifikat/src/data/datasources/remote/sertifikat_remote_datasource.dart';
import 'package:ark_module_sertifikat/src/domain/entities/sertifikat_entitiy.dart';
import 'package:ark_module_sertifikat/src/core/failures.dart';
import 'package:ark_module_sertifikat/src/domain/repositories/sertifikat_repository.dart';
import 'package:dartz/dartz.dart';

class SertifikatRepositoryImpl implements SertifikatRepository {
  final SertifikatRemoteDataSource dataSource;

  SertifikatRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, SertifikatEntity>> getAllCertificate(
      String userId) async {
    try {
      final promo = await dataSource.getAllCertificate(userId);
      return Right(promo);
    } catch (e) {
      if (e is CustomException) {
        return Left(HttpFailure(e.code, e.message));
      } else {
        return const Left(
          HttpFailure(
            500,
            'Error... failed connect to server \nPlease check your connection',
          ),
        );
      }
    }
  }
}
