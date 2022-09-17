import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:ark_module_sertifikat/ark_module_sertifikat.dart';
import 'package:ark_module_sertifikat/src/core/failures.dart';
import 'package:ark_module_sertifikat/src/domain/entities/sertifikat_entitiy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArkSertifikatController extends GetxController {
  final SertifikatUseCase _useCase;

  ArkSertifikatController(this._useCase);

  late SharedPreferences prefs;

  @override
  void onInit() async {
    await _fnSetup();
    await _fnGetAllCertificate();
    await _fnDownloadListener();
    await _fnChangeLoading(false);
    super.onInit();
  }

  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('downloader_cert');
    _port.close();
    super.onClose();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldkey => _scaffoldkey;

  final ReceivePort _port = ReceivePort();

  final Rx<int> _indexSertif = 00.obs;
  Rx<int> get indexSertif => _indexSertif;

  final RxList<int> _progresDownload = <int>[].obs;
  RxList<int> get progresDownload => _progresDownload;

  final Rx<int> _indexTabSertif = 0.obs;
  Rx<int> get indexTabSertif => _indexTabSertif;

  String _userId = '';
  String get userId => _userId;

  final Rx<bool> _isLoading = true.obs;
  Rx<bool> get isLoading => _isLoading;

  TextEditingController txSearch = TextEditingController();

  final Rx<SertifikatEntity> _sertifikat = SertifikatEntity().obs;

  final RxList<SertifikatDataEntity> _listSertifikatResult =
      <SertifikatDataEntity>[].obs;
  RxList<SertifikatDataEntity> get listSertifikatResult =>
      _listSertifikatResult;

  Rx<SertifikatEntity> get sertifikat => _sertifikat;

  Future _fnSetup() async {
    prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('user_id')!;
  }

  Future _fnDownloadListener() async {
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_cert');
    _port.listen((dynamic data) {
      _progresDownload[_indexSertif.value] = data[2];
      DownloadTaskStatus status = data[1];
      log("PROGRESS DOWNLOAD : $_progresDownload");
      if (status == DownloadTaskStatus.complete &&
          _progresDownload[_indexSertif.value] == 100) {
        log("DOWNLOAD RAMPUNG");
        ScaffoldMessenger.of(_scaffoldkey.currentContext!)
            .showSnackBar(SnackBar(
          content: Text(
            'Sertifikat berhasil di unduh',
            style: AppStyleText.styleMontserrat(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          duration: const Duration(milliseconds: 500),
        ));
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_cert');
    send!.send([id, status, progress]);
  }

  void fnOnChangeSertif(int val) {
    _indexTabSertif.value = val;
  }

  Future _fnGetAllCertificate() async {
    final response = await _useCase.getAllCertificate(_userId);
    response.fold(
      (fail) {
        if (fail is HttpFailure) {
          Fluttertoast.showToast(msg: "Error ${fail.code}x : ${fail.message}");
        }
      },
      (SertifikatEntity entity) {
        for (int i = 0; i < entity.certificates!.length; i++) {
          _progresDownload.add(0);
        }
        log("LIST PROGRESS : $_progresDownload");
        _sertifikat.value = entity;
      },
    );
  }

  void fnCheckPermission(int indexVal) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      fnDownloadCertificate(indexVal);
    } else {
      await Permission.storage.request();
    }
  }

  void fnDownloadCertificate(int indexVal) async {
    log("START DOWNLOAD CERTIFICATE");
    _indexSertif.value = indexVal;
    final storageDir = (await _fnFindLocalPath());
    final savedDir = Directory(storageDir!);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    final downloadTask = await FlutterDownloader.enqueue(
      url: sertifikat.value.certificates![indexVal].certificateUrl!,
      savedDir: storageDir,
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
    log("DOWNLOAD CERTIFICATE : $downloadTask");
  }

  Future _fnChangeLoading(bool val) async {
    _isLoading.value = val;
  }

  Future<String?> _fnFindLocalPath() async {
    String? externalStorageDirPath;
    if (GetPlatform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    } else if (GetPlatform.isIOS) {
      externalStorageDirPath = (await getApplicationDocumentsDirectory()).path;
    }
    return externalStorageDirPath;
  }

  void fnOnSearchCertificate(String query) async {
    _fnChangeLoading(true);
    for (var e in _sertifikat.value.certificates!) {
      if (e.courseName!.contains(query)) {
        _listSertifikatResult.add(e);
      }
    }
    _sertifikat.value.certificates = _listSertifikatResult
        .where(
          (e) => e.courseName!.toLowerCase().contains(
                txSearch.text,
              ),
        )
        .toSet()
        .toList();
    log("ON SEARCH LIST : ${_sertifikat.value.certificates!.length}");
    Future.delayed(const Duration(milliseconds: 300), () {
      _fnChangeLoading(false);
    });
  }
}
