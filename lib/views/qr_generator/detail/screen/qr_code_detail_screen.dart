import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QRCodeDetailScreen extends StatelessWidget {
  final String qrCode;

  QRCodeDetailScreen({required this.qrCode});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/chevron-left.png',
              width: width * 0.06,
              color: Theme.of(context).colorScheme.onBackground),
          onPressed: () => GoRouter.of(context).go('/qr-code-list'),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.15),
          child: Text(
            'QR Code Detail'.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: width * 0.10, horizontal: height * 0.02),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: width * 0.75,
            height: height * 0.32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: QrImageView(
              data: qrCode,
              version: QrVersions.auto,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              size: height * 0.30,
            ),
          ),
          SizedBox(height: height * 0.03),
          Container(
            width: width * 0.75,
            height: height * 0.05,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
                qrCode.length > 20 ? '${qrCode.substring(0, 34)}...' : qrCode),
          ),
          SizedBox(height: height * 0.31),
          GestureDetector(
            onTap: () {
              Share.share(qrCode, subject: 'QR Kodum');
            },
            child: Container(
              width: width * 0.95,
              height: height * 0.07,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Share'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
