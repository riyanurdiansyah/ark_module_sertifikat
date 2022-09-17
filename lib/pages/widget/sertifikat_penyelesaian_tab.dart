import 'package:ark_module_sertifikat/ark_module_sertifikat.dart';
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
            Obx(() {
              final sertif = _sC.sertifikat.value.certificates!;
              return Column(
                children: List.generate(
                  sertif.length,
                  (i) => SertifikatCard(
                    imageUrl: sertif[i].certificateUrl!,
                    title: sertif[i].courseName!,
                    date: sertif[i].certificateDate!,
                    onTapUnduh: () => _sC.fnCheckPermission(i),
                    downloadProgress: _sC.progresDownload,
                    index: i,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
