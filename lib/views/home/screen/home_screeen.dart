import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wachat_new_package/component/features_container_component.dart';
import 'package:wachat_new_package/component/main_container_component.dart';
import 'package:wachat_new_package/config/bar/custom_appbar.dart';
import 'package:wachat_new_package/config/bar/custom_navbar.dart';

import 'package:wachat_new_package/controller/home_controller.dart';
import 'package:wachat_new_package/providers/premium_provider.dart';

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
            MainContainerComponent(
              height: height,
              width: width,
              icon: 'assets/logos/home_logo.png',
              darkIcon: 'assets/logos/home_logo_dark.png',
              ref: ref,
              isPremium: isPremium,
              subtitle:
                  'Login to your Web Messanger second account with Wachat',
              buttonText: 'Open Web Messenger',
              onTap: () async {
                await WachatOnTapHandler.handle(
                  context: context,
                  ref: ref,
                  isPremium: isPremium,
                );
              },
            ),
            SizedBox(height: height * 0.015),
            FeaturesContainerComponent(
              width: width,
              height: height,
              onTap: () => context.go('/qr-generator'),
              icon: 'assets/icons/qr_generator.png',
              title: 'QR Generator',
              subtitle: 'Generate QR code',
            ),
            SizedBox(height: height * 0.015),
            FeaturesContainerComponent(
              width: width,
              height: height,
              onTap: () => context.go('/qr-reader'),
              icon: 'assets/icons/qr_scanner.png',
              title: 'QR Scanner',
              subtitle: 'Scan your QR codes',
            ),
            SizedBox(height: height * 0.015),
            FeaturesContainerComponent(
              width: width,
              height: height,
              onTap: () => context.go('/private-note'),
              icon: 'assets/icons/notes.png',
              title: 'Private Note',
              subtitle: 'Keep a secret note',
            ),
            SizedBox(height: height * 0.015),
            FeaturesContainerComponent(
              width: width,
              height: height,
              onTap: () => context.go('/emoji'),
              icon: 'assets/icons/emojis.png',
              title: 'Emojis',
              subtitle: 'More Emoji',
            ),
            SizedBox(height: height * 0.015),
            FeaturesContainerComponent(
              width: width,
              height: height,
              onTap: () => context.go('/sticker'),
              icon: 'assets/icons/stickers.png',
              title: 'Sticker',
              subtitle: 'More Sticker',
            ),
            SizedBox(height: height * 0.015),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentLocation: '/home'),
    );
  }
}
