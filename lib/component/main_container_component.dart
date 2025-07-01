import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainContainerComponent extends StatelessWidget {
  const MainContainerComponent({
    super.key,
    required this.height,
    required this.width,
    required this.ref,
    required this.isPremium,
    required this.subtitle,
    required this.buttonText,
    required this.onTap,
    this.darkIcon,
    required this.icon,
  });

  final double height;
  final double width;
  final WidgetRef ref;
  final bool isPremium;
  final String subtitle;
  final String buttonText;
  final VoidCallback onTap;
  final String? darkIcon;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final displayIcon = isDarkMode && darkIcon != null ? darkIcon! : icon;
    return Container(
      height: height * 0.30,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.03),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    displayIcon,
                    width: width * 0.17,
                  ),
                ),
                SizedBox(
                  height: height * 0.005,
                ),
                Text(
                  'Web Messanger',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: height * 0.005,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Text(subtitle.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Container(
                      height: height * 0.06,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(
                        child: Text(buttonText.tr(),
                            style: Theme.of(context)
                                .textTheme
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
    );
  }
}
