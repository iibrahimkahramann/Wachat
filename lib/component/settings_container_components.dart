import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class SettingsContainerComponents extends StatelessWidget {
  const SettingsContainerComponents({
    super.key,
    required this.width,
    required this.height,
    required this.url,
    required this.icon,
    required this.title,
    this.darkIcon,
  });

  final double width;
  final double height;
  final String url;
  final String icon;
  final String title;
  final String? darkIcon;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final displayIcon = isDarkMode && darkIcon != null ? darkIcon! : icon;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
                  displayIcon,
                  width: width * 0.08,
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Text(
                  title.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
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
