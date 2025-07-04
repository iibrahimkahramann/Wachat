import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../providers/qr_code_generator_provider.dart';
import '../../../../controller/qr_generator_controller.dart';

class QRGeneratorScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final lastQRCode = ref.watch(qrCodeProvider.notifier).getLastQRCode();
    final TextEditingController controller = TextEditingController();

    generateQRCode(controller, ref);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/chevron-left.png',
              width: width * 0.06,
              color: Theme.of(context).colorScheme.onBackground),
          onPressed: () => GoRouter.of(context).go('/home'),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.1),
          child: Text(
            'QR Generator'.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Image.asset('assets/icons/folder.png',
                  width: width * 0.06,
                  color: Theme.of(context).colorScheme.onBackground),
              onPressed: () => GoRouter.of(context).go('/qr-code-list'),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            width * 0.041, height * 0.025, width * 0.041, 0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter Text'.tr(),
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            GestureDetector(
              onTap: () {
                generateQRCode(controller, ref);
              },
              child: Container(
                width: width * 0.95,
                height: height * 0.07,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Generate QR Code'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            if (lastQRCode != null)
              Container(
                width: width * 0.7,
                height: height * 0.3,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    QrImageView(
                      data: lastQRCode,
                      version: QrVersions.auto,
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      size: width * 0.5,
                    ),
                    SizedBox(height: 8),
                    Text(lastQRCode.length > 20
                        ? '${lastQRCode.substring(0, 25)}...'
                        : lastQRCode),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
