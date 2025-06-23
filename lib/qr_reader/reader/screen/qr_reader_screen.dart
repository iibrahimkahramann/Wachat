import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/custom_theme.dart';
import '../../../providers/qr_code_reader_provider.dart';

class QRReaderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final qrCodeData = ref.watch(qrCodeProvider);
    final isCameraActive = qrCodeData["isCameraActive"];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/chevron-left.png',
              width: width * 0.06, color: Colors.black),
          onPressed: () => GoRouter.of(context).go('/home'),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.2),
          child: Text(
            'QR Reader'.tr(),
            style: CustomTheme.textTheme(context)
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Image.asset('assets/icons/folder.png',
                  width: width * 0.06, color: Colors.black),
              onPressed: () => GoRouter.of(context).go('/scanned-qr-codes'),
            ),
          ),
        ],
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            width * 0.041, height * 0.025, width * 0.041, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: isCameraActive
                  ? MobileScanner(
                      onDetect: (barcodeCapture) {
                        final String code =
                            barcodeCapture.barcodes.first.rawValue ??
                                "Scanned QR code data is empty".tr();
                        ref.read(qrCodeProvider.notifier).addScannedCode(code);
                      },
                    )
                  : Container(
                      width: width * 0.95,
                      height: height * 0.10,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Lottie.asset(
                          'assets/icons/qr.json',
                          width: width * 0.55,
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            GestureDetector(
              onTap: () {
                ref.read(qrCodeProvider.notifier).toggleCamera();
              },
              child: Container(
                width: width * 0.95,
                height: height * 0.07,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 37, 211, 102),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Read QR Code'.tr(),
                    style: CustomTheme.textTheme(context)
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
          ],
        ),
      ),
    );
  }
}
