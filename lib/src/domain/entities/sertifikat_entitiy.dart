class SertifikatEntity {
  bool? success;
  List<SertifikatDataEntity>? certificates;
  bool error = false;
  String messgaeError = '';

  SertifikatEntity({
    this.success,
    this.certificates,
  });

  SertifikatEntity.withError(String errorMessage) {
    success = false;
    certificates = <SertifikatDataEntity>[];
    error = true;
    messgaeError = errorMessage;
  }
}

class SertifikatDataEntity {
  int? id;
  String? courseName;
  String? certificateDate;
  String? certificateUrl;
  String? certificateId;
  int? remainingGen;

  SertifikatDataEntity({
    this.id,
    this.courseName,
    this.certificateDate,
    this.certificateUrl,
    this.certificateId,
    this.remainingGen,
  });
}
