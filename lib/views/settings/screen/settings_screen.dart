import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wachat_new_package/component/main_container_component.dart';
import 'package:wachat_new_package/component/settings_container_components.dart';
import 'package:wachat_new_package/component/settings_rate_us.dart';
import 'package:wachat_new_package/config/bar/custom_appbar.dart';
import 'package:wachat_new_package/config/bar/custom_navbar.dart';
import 'package:wachat_new_package/controller/home_controller.dart';
import 'package:wachat_new_package/providers/premium_provider.dart';
import 'package:wachat_new_package/providers/theme_provider.dart';

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
              MainContainerComponent(
                icon: 'assets/logos/home_logo.png',
                darkIcon: 'assets/logos/home_logo_dark.png',
                height: height,
                width: width,
                ref: ref,
                isPremium: isPremium,
                subtitle: 'Join us to enjoy Premium Features and Privileges',
                buttonText: 'Upgrade to Premium',
                onTap: () async {
                  await RevenueCatService.showPaywallIfNeeded();
                },
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
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/theme.png',
                    width: width * 0.08,
                    height: width * 0.08,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Text(
                    'Dark Mode'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Spacer(),
                  Switch(
                    value: ref.watch(themeProvider) == ThemeMode.dark,
                    onChanged: (value) {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SettingsContainerComponents(
              width: width,
              height: height,
              url: 'https://sites.google.com/view/wachat-privacy/ana-sayfa',
              icon: 'assets/icons/privacy.png',
              darkIcon: 'assets/icons/privacy_dark.png',
              title: 'Privacy Policy',
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SettingsContainerComponents(
              width: width,
              height: height,
              url: 'https://sites.google.com/view/wachat-terms/ana-sayfa',
              icon: 'assets/icons/terms.png',
              darkIcon: 'assets/icons/terms_dark.png',
              title: 'Terms of Use',
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SettingsContainerComponents(
              width: width,
              height: height,
              url:
                  'https://myaccount.google.com/intro/payments-and-subscriptions',
              icon: 'assets/icons/subscriptions.png',
              darkIcon: 'assets/icons/subscriptions_Dark.png',
              title: 'Subscriptions',
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SettingsRateUs(
                width: width,
                height: height,
                icon: 'assets/icons/star.png',
                darkIcon: 'assets/icons/star_dark.png'),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentLocation: '/settings'),
    );
  }
}
