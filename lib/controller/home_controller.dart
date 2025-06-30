import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wachat_new_package/firebase/firebase_analytics.dart';
import 'package:wachat_new_package/providers/first_launch_provider.dart';

Future<void> checkAndRequestReview() async {
  final InAppReview inAppReview = InAppReview.instance;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool hasRated = prefs.getBool('hasRated') ?? false;

  if (!hasRated) {
    try {
      final isAvailable = await inAppReview.isAvailable();
      if (isAvailable) {
        await inAppReview.requestReview();
        prefs.setBool('hasRated', true);
      } else {
        print('In-app review is not available');
      }
    } catch (e) {
      print('Error requesting review: $e');
    }
  }
}

Future<void> homePaywall() async {}

class RevenueCatService {
  static Future<void> showPaywallIfNeeded() async {
    final paywallResult = await RevenueCatUI.presentPaywallIfNeeded("premium");
    print('Paywall result: $paywallResult');
  }
}



class WachatOnTapHandler {
  static Future<void> handle({
    required BuildContext context,
    required WidgetRef ref,
    required bool isPremium,
  }) async {
    final isFirstLaunch = await ref.read(firstLaunchProvider.future);
    final prefs = await SharedPreferences.getInstance();
    final wachatTrialUsed = prefs.getBool('wachatTrialUsed') ?? false;
    if (isFirstLaunch && !wachatTrialUsed) {
      await setFirstLaunchDone();
      AnalyticsService.analytics.logEvent(name: 'Wachat Giriş');
      context.go('/wachat');
    } else {
      if (isPremium) {
        AnalyticsService.analytics.logEvent(name: 'Wachat Giriş');
        context.go('/wachat');
      } else if (!wachatTrialUsed) {
        AnalyticsService.analytics.logEvent(name: 'Wachat Giriş');
        context.go('/wachat');
      } else {
        await RevenueCatService.showPaywallIfNeeded();
      }
    }
  }
}