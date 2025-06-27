import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';

import 'package:url_launcher/link.dart';
import 'package:wachat_new_package/bar/custom_appbar.dart';
import 'package:wachat_new_package/bar/custom_navbar.dart';
import 'package:wachat_new_package/home/controller/home_controller.dart';
import 'package:wachat_new_package/providers/premium_provider.dart';

import '../../config/custom_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(width * 0.041, height * 0.01, width * 0.041, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isPremium)
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
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.1),
                          child: Text(
                              'Join us to enjoy Premium Features and Privileges'
                                  .tr(),
                              textAlign: TextAlign.center,
                              style: CustomTheme.textTheme(context).bodyMedium),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await RevenueCatService.showPaywallIfNeeded();
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
                                child: Text('Upgrade to Premium'.tr(),
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
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Link(
                uri: Uri.parse(
                    'https://sites.google.com/view/wachat-privacy/ana-sayfa'),
                builder: (context, followLink) => Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: followLink,
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/privacy.png',
                          width: width * 0.08,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          'Privacy Policy'.tr(),
                          style: CustomTheme.textTheme(context)
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.left, // Metni sola hizalar
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Link(
                uri: Uri.parse(
                    'https://sites.google.com/view/wachat-terms/ana-sayfa'),
                builder: (context, followLink) => Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: followLink,
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/terms.png',
                          width: width * 0.08,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          'Terms of Use'.tr(),
                          style: CustomTheme.textTheme(context)
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.left, // Metni sola hizalar
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Link(
                uri: Uri.parse(
                    'https://myaccount.google.com/intro/payments-and-subscriptions'),
                builder: (context, followLink) => Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: followLink,
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/subscriptions.png',
                          width: width * 0.08,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          'Subscriptions'.tr(),
                          style: CustomTheme.textTheme(context)
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.left, // Metni sola hizalar
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () async {
                  final InAppReview inAppReview = InAppReview.instance;
                  if (await inAppReview.isAvailable()) {
                    await inAppReview.requestReview();
                  } else {
                    await inAppReview.openStoreListing();
                  }
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/star.png',
                      width: width * 0.08,
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Text(
                      'Rate Us'.tr(),
                      style: CustomTheme.textTheme(context)
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentLocation: '/settings'),
    );
  }
}
