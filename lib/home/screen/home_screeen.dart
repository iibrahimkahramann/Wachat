import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wachat_new_package/bar/custom_appbar.dart';
import 'package:wachat_new_package/bar/custom_navbar.dart';
import 'package:wachat_new_package/config/custom_theme.dart';
import 'package:wachat_new_package/firebase/firebase_analytics.dart';
import 'package:wachat_new_package/home/controller/home_controller.dart';
import 'package:wachat_new_package/providers/premium_provider.dart';
import 'package:wachat_new_package/providers/first_launch_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreeen extends ConsumerStatefulWidget {
  const HomeScreeen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends ConsumerState<HomeScreeen> {
  bool hasSeenPaywall = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 0), () {
        if (!hasSeenPaywall) {
          checkAndRequestReview();

          hasSeenPaywall = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.fromLTRB(width * 0.041, height * 0.01, width * 0.041, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height * 0.31,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset('assets/images/home_background.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/logos/home_logo.png',
                          width: width * 0.17,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Text(
                        'Web Messanger',
                        style: CustomTheme.textTheme(context).bodyLarge,
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                        child: Text(
                            'Login to your Web Messanger second account with Wachat'
                                .tr(),
                            textAlign: TextAlign.center,
                            style: CustomTheme.textTheme(context).bodyMedium),
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final isFirstLaunch =
                              await ref.read(firstLaunchProvider.future);
                          final prefs = await SharedPreferences.getInstance();
                          final wachatTrialUsed =
                              prefs.getBool('wachatTrialUsed') ?? false;
                          if (isFirstLaunch && !wachatTrialUsed) {
                            await setFirstLaunchDone();
                            AnalyticsService.analytics
                                .logEvent(name: 'Wachat Giriş');
                            context.go('/wachat');
                          } else {
                            if (isPremium) {
                              AnalyticsService.analytics
                                  .logEvent(name: 'Wachat Giriş');
                              context.go('/wachat');
                            } else if (!wachatTrialUsed) {
                              AnalyticsService.analytics
                                  .logEvent(name: 'Wachat Giriş');
                              context.go('/wachat');
                            } else {
                              // 1 kerelik hak kullanıldıysa ve premium değilse paywall göster
                              await RevenueCatService.showPaywallIfNeeded();
                            }
                          }
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Container(
                            height: height * 0.06,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 37, 211, 102)),
                            child: Center(
                              child: Text('Open Web Messenger'.tr(),
                                  style: CustomTheme.textTheme(context)
                                      .bodyMedium
                                      ?.copyWith(color: Colors.white)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.005, horizontal: width * 0.04),
              child: Text(
                'FEATURES'.tr(),
                style: CustomTheme.textTheme(context)
                    .bodyLarge
                    ?.copyWith(fontFamily: ''),
              ),
            ),
            SizedBox(height: height * 0.005),
            GestureDetector(
              onTap: () => context.go('/qr-generator'),
              child: Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/qr_generator.png',
                        width: width * 0.14,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'QR Generator'.tr(),
                            style: CustomTheme.textTheme(context).bodyLarge,
                          ),
                          Text(
                            'Generate QR code'.tr(),
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black.withAlpha(160)),
                          ),
                        ],
                      ),
                      Spacer(), // To push the icon to the end of the row
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            GestureDetector(
              onTap: () => context.go('/qr-reader'),
              child: Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/qr_scanner.png',
                        width: width * 0.14,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'QR Scanner'.tr(),
                            style: CustomTheme.textTheme(context).bodyLarge,
                          ),
                          Text(
                            'Scan your QR codes'.tr(),
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black.withAlpha(160)),
                          ),
                        ],
                      ),
                      Spacer(), // To push the icon to the end of the row
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            GestureDetector(
              onTap: () => context.go('/private-note'),
              child: Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/notes.png',
                        width: width * 0.14,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Private Note'.tr(),
                            style: CustomTheme.textTheme(context).bodyLarge,
                          ),
                          Text(
                            'Keep a secret note'.tr(),
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black.withAlpha(160)),
                          ),
                        ],
                      ),
                      Spacer(), // To push the icon to the end of the row
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            GestureDetector(
              onTap: () => context.go('/emoji'),
              child: Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/emojis.png',
                        width: width * 0.14,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Emojis'.tr(),
                            style: CustomTheme.textTheme(context).bodyLarge,
                          ),
                          Text(
                            'More Emoji'.tr(),
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black.withAlpha(160)),
                          ),
                        ],
                      ),
                      Spacer(), // To push the icon to the end of the row
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            GestureDetector(
              onTap: () => context.go('/sticker'),
              child: Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/stickers.png',
                        width: width * 0.14,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sticker'.tr(),
                            style: CustomTheme.textTheme(context).bodyLarge,
                          ),
                          Text(
                            'More Sticker'.tr(),
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black.withAlpha(160)),
                          ),
                        ],
                      ),
                      Spacer(), // To push the icon to the end of the row
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentLocation: '/home'),
    );
  }
}
