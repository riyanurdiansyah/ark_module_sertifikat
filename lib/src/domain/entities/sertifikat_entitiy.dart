class SertifikatEntity {
  bool? success;
  List<SertifikatDataEntity>? certificates;

  SertifikatEntity({
    this.success,
    this.certificates,
  });
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
