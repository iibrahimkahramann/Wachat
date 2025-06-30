import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wachat_new_package/component/main_container_component.dart';
import 'package:wachat_new_package/component/settings_container_components.dart';
import 'package:wachat_new_package/component/settings_rate_us.dart';
import 'package:wachat_new_package/config/bar/custom_appbar.dart';
import 'package:wachat_new_package/config/bar/custom_navbar.dart';
import 'package:wachat_new_package/controller/home_controller.dart';
import 'package:wachat_new_package/providers/premium_provider.dart';

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
            MainContainerComponent(height: height, width: width, ref: ref, isPremium: isPremium, subtitle: 'Join us to enjoy Premium Features and Privileges', buttonText: 'Upgrade to Premium', onTap: () async {
                            await RevenueCatService.showPaywallIfNeeded();
                          },),
            SettingsContainerComponents(width: width, height: height, url: 'https://sites.google.com/view/wachat-privacy/ana-sayfa', icon: 'assets/icons/privacy.png', title: 'Privacy Policy',),
            SizedBox(
              height: height * 0.01,
            ),
            SettingsContainerComponents(width: width, height: height, url: 'https://sites.google.com/view/wachat-terms/ana-sayfa', icon: 'assets/icons/terms.png', title: 'Terms of Use',),
            SizedBox(
              height: height * 0.01,
            ),
            SettingsContainerComponents(width: width, height: height, url: 'https://myaccount.google.com/intro/payments-and-subscriptions', icon: 'assets/icons/subscriptions.png', title: 'Subscriptions',),
            SizedBox(
              height: height * 0.01,
            ),
            SettingsRateUs(width: width, height: height),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentLocation: '/settings'),
    );
  }
}

