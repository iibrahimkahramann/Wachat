import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/qr_code_generator_provider.dart';

void generateQRCode(TextEditingController controller, WidgetRef ref) {
  if (controller.text.isNotEmpty) {
    ref.read(qrCodeProvider.notifier).addQRCode(controller.text);
    controller.clear();
  }
}
