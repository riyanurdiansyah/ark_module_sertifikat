import 'package:ark_module_sertifikat/ark_module_sertifikat.dart';
import 'package:ark_module_sertifikat/pages/widget/sertifikat_penyelesaian_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArkSertifikatPage extends StatelessWidget {
  ArkSertifikatPage({Key? key}) : super(key: key);
  final _sC = Get.find<ArkSertifikatController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sC.scaffoldkey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Sertifikat",
          style: AppStyleText.styleMontserrat(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xFF139DD6),
                Color(0xFF0977BE),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _sC.txSearch,
                      onChanged: (query) => _sC.fnOnSearchCertificate(query),
                      style: AppStyleText.styleMontserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      decoration: AppStyleTextField.customOutlined(
                        '',
                        'Cari sertifikat',
                        const Icon(
                          Icons.search_rounded,
                          size: 18,
                        ),
                        null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      style: AppStyleText.styleMontserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      decoration: AppStyleTextField.customOutlined(
                        'Urutkan',
                        '',
                        null,
                        const Icon(
                          Icons.expand_more_rounded,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => _sC.fnOnChangeSertif(0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _sC.indexTabSertif.value == 0
                                ? const Color(0xFFDEF1FD)
                                : Colors.white,
                            border: Border.all(
                              color: _sC.indexTabSertif.value == 0
                                  ? const Color(0xFFDEF1FD)
                                  : Colors.grey.shade300,
                            )),
                        child: Text(
                          'Sertifikat Penyelesaian',
                          style: AppStyleText.styleMontserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: _sC.indexTabSertif.value == 0
                                ? const Color(0xFF0977BE)
                                : const Color(0xFF838589),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => _sC.fnOnChangeSertif(1),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: _sC.indexTabSertif.value == 1
                                  ? const Color(0xFFDEF1FD)
                                  : Colors.white,
                              border: Border.all(
                                color: _sC.indexTabSertif.value == 1
                                    ? const Color(0xFFDEF1FD)
                                    : Colors.grey.shade300,
                              )),
                          child: Text(
                            'Sertifikat Kompetensi Kelulusan',
                            style: AppStyleText.styleMontserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _sC.indexTabSertif.value == 1
                                  ? const Color(0xFF0977BE)
                                  : const Color(0xFF838589),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(() {
              if (_sC.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return IndexedStack(
                  index: _sC.indexTabSertif.value,
                  children: [
                    SertifikatPenyelesaianTab(),
                    Container(
                      color: Colors.red,
                    )
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
