import 'package:ark_module_sertifikat/ark_module_sertifikat.dart';
import 'package:ark_module_sertifikat/pages/widget/sertifikat_card_shimmer.dart';
import 'package:ark_module_sertifikat/pages/widget/sertifikat_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sertifikat_card.dart';

class SertifikatPenyelesaianTab extends StatelessWidget {
  SertifikatPenyelesaianTab({Key? key}) : super(key: key);

  final _sC = Get.find<ArkSertifikatController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  alignment: Alignment.center,
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFDA00),
                        Color(0xFFFFB200),
                      ],
                    ),
                  ),
                  child: Text(
                    'i',
                    style: AppStyleText.styleMontserrat(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: 'Sertifikat Penyelesaian ',
                      style: AppStyleText.styleSourceSansPro(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: "akan anda dapatkan setelah ",
                          style: AppStyleText.styleSourceSansPro(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                        TextSpan(
                          text: 'menyelesaikan seluruh seri dan kuis ',
                          style: AppStyleText.styleSourceSansPro(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                        ),
                        TextSpan(
                          text: "dalam kursus (tanpa nilai minimum).",
                          style: AppStyleText.styleSourceSansPro(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Obx(
              () {
                if (_sC.isLoading.value) {
                  return Column(
                    children: List.generate(
                      3,
                      (index) => const SertifikatCardShimmer(),
                    ),
                  );
                } else if (_sC.sertifikat.value.error) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.running_with_errors_rounded,
                        size: 125,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        _sC.sertifikat.value.messgaeError,
                        style: AppStyleText.styleMontserrat(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () => _sC.fnGetAllCertificate(),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text(
                          'Refresh',
                          style: AppStyleText.styleMontserrat(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (_sC.sertifikat.value.certificates!.isEmpty) {
                  return const SertifikatEmptyWidget();
                } else {
                  final sertif = _sC.sertifikat.value.certificates!;
                  return Column(
                    children: List.generate(
                      sertif.length,
                      (i) => SertifikatCard(
                        imageUrl: sertif[i].certificateUrl!,
                        title: sertif[i].courseName!,
                        date: sertif[i].certificateDate!,
                        onTapUnduh: () => _sC.fnCheckPermission(i),
                        onTapShare: () => _sC.fnSharedCertificate(),
                        downloadProgress: _sC.progresDownload,
                        index: i,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
