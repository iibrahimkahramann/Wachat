import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FeaturesContainerComponent extends StatelessWidget {
  const FeaturesContainerComponent({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,

  });

  final double width;
  final double height;
  final VoidCallback onTap;
  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height * 0.1,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Row(
            children: [
              Image.asset(
                icon,
                width: width * 0.14,
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    subtitle.tr(),
                    style: Theme.of(context)
                        .textTheme.bodyMedium
                        ?.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color?.withAlpha(160)),
                  ),
                ],
              ),
              Spacer(), 
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

