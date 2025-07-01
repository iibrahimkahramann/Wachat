import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/qr_code_reader_provider.dart';

class ScannedQRCodesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final qrCodeData = ref.watch(qrCodeProvider);
    final scannedCodes = qrCodeData["scannedCodes"] ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/chevron-left.png',
              width: width * 0.06, color: Theme.of(context).colorScheme.onBackground),
          onPressed: () => GoRouter.of(context).go('/qr-reader'),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.1),
          child: Text(
            'Scanned QR Codes'.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            width * 0.041, height * 0.025, width * 0.041, 0),
        child: scannedCodes.isEmpty
            ? Center(
                child: Text(
                  'No scanned QR codes yet.'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
                ),
              )
            : ListView.builder(
                itemCount: scannedCodes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: height * 0.015),
                    padding: EdgeInsets.all(height * 0.015),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            scannedCodes[index].length > 20
                                ? '${scannedCodes[index].substring(0, 20)}...'
                                : scannedCodes[index], 
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            ref
                                .read(qrCodeProvider.notifier)
                                .removeScannedCode(scannedCodes[index]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('QR code deleted!'.tr())),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
