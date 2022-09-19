import 'package:ark_module_sertifikat/utils/app_style_text.dart';
import 'package:flutter/material.dart';

class SertifikatEmptyWidget extends StatelessWidget {
  const SertifikatEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 35,
        ),
        Image.asset(
          'assets/images/empty_state.png',
          width: 150,
        ),
        const SizedBox(
          height: 26,
        ),
        Text(
          'Sertifikat tidak ditemukan',
          style: AppStyleText.styleMontserrat(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
