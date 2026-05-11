import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../models/models.dart';

class TechStackCard extends StatelessWidget {
  final TechStack tech;
  final VoidCallback? onTap;

  const TechStackCard({
    Key? key,
    required this.tech,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundWhite,
      elevation: AppDimensions.elevationSmall,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Row(
            children: [
              CircleAvatar(
                radius: AppDimensions.paddingLarge,
                backgroundColor: tech.color,
              ),
              const SizedBox(width: AppDimensions.marginMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tech.title,
                      style: const TextStyle(
                        color: AppColors.textBlue,
                        fontSize: AppDimensions.fontSizeLarge,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.marginSmall),
                    Text(
                      tech.platform,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontSizeMedium,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.marginSmall),
                    Text(
                      tech.lang,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontSizeMedium,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
