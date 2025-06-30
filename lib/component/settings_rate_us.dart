import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:wachat_new_package/config/custom_theme.dart';

class SettingsRateUs extends StatelessWidget {
  const SettingsRateUs({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

