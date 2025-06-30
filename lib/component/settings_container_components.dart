import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:wachat_new_package/config/custom_theme.dart';

class SettingsContainerComponents extends StatelessWidget {
  const SettingsContainerComponents({
    super.key,
    required this.width,
    required this.height,
    required this.url,
    required this.icon,
    required this.title,
  });

  final double width;
  final double height;
  final String url;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            url),
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
                  icon,
                  width: width * 0.08,
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Text(
                  title.tr(),
                  style: CustomTheme.textTheme(context)
                      .bodyMedium
                      ?.copyWith(color: Colors.black),
                  textAlign: TextAlign.left, 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
