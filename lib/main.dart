import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wachat_new_package/config/custom_theme.dart';
import 'package:wachat_new_package/config/router.dart' as app_router;
import 'package:wachat_new_package/firebase_options.dart';
import 'package:wachat_new_package/init/initialize.dart';
import 'package:wachat_new_package/providers/premium_provider.dart';
import 'package:wachat_new_package/providers/rate_us_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Future<void> _configureRcsdk() async {
    print("Configure Rcsdk *************");
    await Purchases.setLogLevel(LogLevel.debug);
    PurchasesConfiguration? configuration;

    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration("goog_JWdrtCwPgjBxcOfhfNOQHOqqoOB");
    } else if (Platform.isIOS) {
      configuration =
          PurchasesConfiguration("goog_JWdrtCwPgjBxcOfhfNOQHOqqoOB");
    }
    await Purchases.configure(configuration!);

    // if (configuration != null) {
    //   await Purchases.configure(configuration);

    //   final paywallResult = await RevenueCatUI.presentPaywallIfNeeded("pro");
    //   print("paywall result: $paywallResult");
    // }
  }

  await _configureRcsdk();

  await EasyLocalization.ensureInitialized();

  await Init.instance.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', ''),
        Locale('tr', ''),
        Locale('fr', ''),
        Locale('it', ''),
        Locale('pt', ''),
        Locale('es', ''),
        Locale('de', ''),
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('en', ''),
      useOnlyLangCode: true,
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  bool _appIsReady = false;
  Timer? _rateUsTimer;

  @override
  void initState() {
    super.initState();

    setupRevenueCatListener(ref); // Burada artık ref erişilebilir

    // Simulate some initialization work
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _appIsReady = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_rateUsTimer == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startRateUsTimer();
      });
    }
  }

  void _startRateUsTimer() {
    _rateUsTimer = Timer(Duration(seconds: 40), () {
      if (mounted) {
        showDialog(
          context: app_router.rootNavigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: RateUsDialogWithDelayedClose(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _rateUsTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_appIsReady) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp.router(
      title: 'Wachat',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.themeData(context),
      routerConfig: app_router.appRouter,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }

  void setupRevenueCatListener(WidgetRef ref) {
    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      final entitlement = customerInfo.entitlements.all["premium"];
      ref
          .read(isPremiumProvider.notifier)
          .updatePremiumStatus(entitlement?.isActive ?? false);
      print("Riverpod ile abone kontrolü: ${entitlement?.isActive ?? false}");
    });
  }
}
