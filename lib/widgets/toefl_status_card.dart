import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../models/models.dart';

class ToeflStatusCard extends StatelessWidget {
  final ToeflScore score;

  const ToeflStatusCard({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.marginMedium,
        vertical: AppDimensions.marginXLarge,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryDarkBlue,
            AppColors.primaryGradientEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: AppDimensions.paddingLarge),
          const Text(
            AppStrings.toeflStatus,
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: AppDimensions.fontSizeMedium,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          Text(
            score.status,
            style: const TextStyle(
              color: AppColors.textWhite,
              fontSize: AppDimensions.fontSizeHuge,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.25,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Listening\n      ${score.listening}',
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: AppDimensions.fontSizeLarge,
                  ),
                ),
                Text(
                  'Structure\n      ${score.structure}',
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: AppDimensions.fontSizeLarge,
                  ),
                ),
                Text(
                  'Reading\n      ${score.reading}',
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: AppDimensions.fontSizeLarge,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
        ],
      ),
    );
  }
}
