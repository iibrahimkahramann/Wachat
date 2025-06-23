import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodeNotifier extends StateNotifier<List<String>> {
  QRCodeNotifier() : super([]) {
    _loadQRcodes();
  }

  void addQRCode(String code) {
    state = [...state, code];
    _saveQRcodes();
  }

  Future<void> _loadQRcodes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedQRcodes = prefs.getStringList('qrCodes');
    if (savedQRcodes != null) {
      state = savedQRcodes;
    }
  }

  Future<void> _saveQRcodes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('qrCodes', state);
  }

  String? getLastQRCode() {
    return state.isNotEmpty ? state.last : null;
  }
}

final qrCodeProvider =
    StateNotifierProvider<QRCodeNotifier, List<String>>((ref) {
  return QRCodeNotifier();
});
