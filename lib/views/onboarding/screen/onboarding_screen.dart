import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wachat_new_package/config/custom_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding_background.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.02,
                    horizontal: width * 0.35,
                  ),
                  child: Image.asset(
                    'assets/logos/logo.png',
                    height: height * 0.04,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: width * 0.05),
                  child: Image.asset(
                    'assets/images/onboarding_image.png',
                    height: height * 0.55,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.001,
                    horizontal: width * 0.1,
                  ),
                  child: Center(
                    child: Text('Are you ready?'.tr(),
                        textAlign: TextAlign.center,
                        style: CustomTheme.textTheme(context)
                            .bodyLarge
                            ?.copyWith(
                                color: Colors.white, fontSize: width * 0.065)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.0,
                    horizontal: width * 0.12,
                  ),
                  child: Center(
                    child: Text(
                        'Add your second WA account now and enjoy the freedom of dual accounts!'
                            .tr(),
                        textAlign: TextAlign.center,
                        style: CustomTheme.textTheme(context)
                            .bodyMedium
                            ?.copyWith(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('onboardingSeen', true);
                    context.go('/home');
                  },
                  child: Container(
                    width: width * 0.93,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 52, 168, 83),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Let s start'.tr(),
                        style: CustomTheme.textTheme(context)
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
