import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/custom_theme.dart';
import '../../../providers/qr_code_generator_provider.dart';

class QRCodeListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrCodes = ref.watch(qrCodeProvider);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/chevron-left.png',
              width: width * 0.06, color: Colors.black),
          onPressed: () => GoRouter.of(context).go('/qr-generator'),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.23),
          child: Text(
            'QR List'.tr(),
            style: CustomTheme.textTheme(context)
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(width * 0.041, height * 0.02, width * 0.041, 0),
        child: qrCodes.isEmpty
            ? Center(
                child: Text(
                  'No QR code generated yet.'.tr(),
                  style: CustomTheme.textTheme(context)
                      .bodyMedium
                      ?.copyWith(color: Colors.grey[400]),
                ),
              )
            : ListView.builder(
                itemCount: qrCodes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: height * 0.015),
                    padding: EdgeInsets.all(height * 0.015),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          qrCodes[index].length > 20
                              ? '${qrCodes[index].substring(0, 20)}...' // İlk 20 karakter ve "..."
                              : qrCodes[index], // Tam metin
                          style: CustomTheme.textTheme(context)
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                          ),
                          onPressed: () => context.go('/qr-code-detail',
                              extra: qrCodes[index]),
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
