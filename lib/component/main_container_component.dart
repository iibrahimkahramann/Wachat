import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wachat_new_package/config/custom_theme.dart';

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
  });

  final double height;
  final double width;
  final WidgetRef ref;
  final bool isPremium;
  final String subtitle;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.30,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: CustomTheme.secondaryColor,
      ),
      child: Stack(
        children: [
          Image.asset('assets/images/home_background.png'),
          Padding(
            padding: EdgeInsets.only(top: height * 0.03),
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
                  child: Text(subtitle.tr(),
                      textAlign: TextAlign.center,
                      style: CustomTheme.textTheme(context).bodyMedium),
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
                        color: CustomTheme.primaryColor,
                      ),
                      child: Center(
                        child: Text(buttonText.tr(),
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
    );
  }
}
