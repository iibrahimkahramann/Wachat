import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wachat_new_package/controller/home_controller.dart';
import 'package:wachat_new_package/providers/premium_provider.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isPremium = ref.watch(isPremiumProvider);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: SafeArea(
        child: SizedBox(
          height: kToolbarHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.035,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/logos/logo.png',
                  height: height * 0.029,
                ),
                Spacer(),
                if (!isPremium)
                  GestureDetector(
                    onTap: () async {
                      await RevenueCatService.showPaywallIfNeeded();
                    },
                    child: Container(
                      width: width * 0.12,
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Image.asset('assets/icons/pro.png',
                          width: width * 0.07),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
