import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

class SettingsRateUs extends StatelessWidget {
  const SettingsRateUs({
    super.key,
    required this.width,
    required this.height,
    required this.icon,
    this.darkIcon,
  });

  final double width;
  final double height;
  final String icon;
  final String? darkIcon;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final displayIcon = isDarkMode && darkIcon != null ? darkIcon! : icon;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
              displayIcon,
              width: width * 0.08,
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              'Rate Us'.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

