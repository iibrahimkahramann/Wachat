import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wachat_new_package/emoji/screen/emoji_screen.dart';
import 'package:wachat_new_package/home/screen/home_screeen.dart';
import 'package:wachat_new_package/note/note/screen/private_note_screen.dart';
import 'package:wachat_new_package/sticker/screen/sticker_screen.dart';
import 'package:wachat_new_package/wachat/screen/wachat_screen.dart';
import '../onboarding/screen/onboarding_screen.dart';
import '../qr_generator/detail/screen/qr_code_detail_screen.dart';
import '../qr_generator/list/screen/qr_code_list_screen.dart';
import '../qr_reader/reader/screen/qr_reader_screen.dart';
import '../qr_generator/generator/screen/qr_generator_screen.dart';
import '../qr_reader/scanned/screen/scanned_qr_codes_screen.dart';
import '../settings/screen/settings_screen.dart';
import '../note/list/screen/note_list_screen.dart';
import '../note/detail/screen/note_detail_screen.dart';
import '../splash/screen/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SplashScreen()),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeScreeen()),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SettingsScreen()),
    ),
    GoRoute(
      path: '/qr-reader',
      name: 'qr reader',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: QRReaderScreen()),
    ),
    GoRoute(
      path: '/qr-generator',
      name: 'qr generator',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: QRGeneratorScreen()),
    ),
    GoRoute(
      path: '/qr-code-list',
      name: 'qr code list',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: QRCodeListScreen()),
    ),
    GoRoute(
      path: '/qr-code-detail',
      name: 'qr code detail',
      pageBuilder: (context, state) {
        final qrCode = state.extra as String;
        return NoTransitionPage(child: QRCodeDetailScreen(qrCode: qrCode));
      },
    ),
    GoRoute(
      path: '/private-note',
      name: 'private note',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: PrivateNoteScreen()),
    ),
    GoRoute(
      path: '/note-list',
      builder: (context, state) => NoteListScreen(),
    ),
    GoRoute(
      path: '/note-detail/:index',
      builder: (context, state) {
        final index = int.parse(state.pathParameters['index']!);
        return NoteDetailScreen(noteIndex: index);
      },
    ),
    GoRoute(
      path: '/emoji',
      name: 'emoji',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: EmojiListScreen()),
    ),
    GoRoute(
      path: '/sticker',
      name: 'sticker',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: StickerListScreen()),
    ),
    GoRoute(
      path: '/scanned-qr-codes',
      name: 'scanned qr codes',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: ScannedQRCodesScreen()),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: OnboardingScreen()),
    ),
    GoRoute(
      path: '/wachat',
      name: 'wachat',
      pageBuilder: (context, state) => NoTransitionPage(
          child: WachatScreen(
        url: 'https://web.whatsapp.com/en',
      )),
    ),
  ],
);

final GoRouter appRouter = router;
final GlobalKey<NavigatorState> rootNavigatorKey = _rootNavigatorKey;
