import 'package:ark_module_sertifikat/src/domain/entities/sertifikat_entitiy.dart';

class SertifikatDTO implements SertifikatEntity {
  @override
  bool? success;

  @override
  List<SertifikatDataEntity>? certificates;

  @override
  bool error = false;

  @override
  String messgaeError = '';

  SertifikatDTO({
    required this.success,
    required this.certificates,
  });

  factory SertifikatDTO.fromJson(Map<String, dynamic> json) => SertifikatDTO(
        success: json['success'],
        certificates: List<SertifikatDataDTO>.from(
          json["certificates"].map(
            (e) => SertifikatDataDTO.fromJson(e),
          ),
        ),
      );
}

class SertifikatDataDTO implements SertifikatDataEntity {
  @override
  String? certificateDate;

  @override
  String? certificateId;

  @override
  String? certificateUrl;

  @override
  String? courseName;

  @override
  int? id;

  @override
  int? remainingGen;

  SertifikatDataDTO({
    required this.id,
    required this.courseName,
    required this.certificateDate,
    required this.certificateUrl,
    required this.certificateId,
    required this.remainingGen,
  });

  factory SertifikatDataDTO.fromJson(Map<String, dynamic> json) =>
      SertifikatDataDTO(
        id: json['id'],
        courseName: json['course_name'] ?? '',
        certificateDate: json['cert_date'] ?? '',
        certificateUrl: json['cert_url'] ?? '',
        certificateId: json['cert_id'] ?? '',
        remainingGen: json['remaining_gen'] ?? '',
      );
}
