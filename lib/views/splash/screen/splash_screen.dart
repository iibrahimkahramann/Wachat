import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wachat_new_package/providers/premium_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(isPremiumProvider);

    Future.delayed(
      const Duration(seconds: 2),
      () async {
        final prefs = await SharedPreferences.getInstance();
        final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? false;
        if (!isPremium) {
          if (isFirstLaunch) {
            context.go('/home');
          } else {
            context.go('/onboarding');
          }
        } else {
          context.go('/wachat');
        }
      },
    );

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logos/logo.png',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
