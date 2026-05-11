import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../models/models.dart';

class StudentProfileHeader extends StatelessWidget {
  final Student student;
  final String? welcomeText;

  const StudentProfileHeader({
    Key? key,
    required this.student,
    this.welcomeText = AppStrings.welcomeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                welcomeText!,
                style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: AppDimensions.fontSizeXXLarge,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.25,
                ),
              ),
              Text(
                student.studentId,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeMedium,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const CircleAvatar(
            radius: AppDimensions.avatarRadius,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
