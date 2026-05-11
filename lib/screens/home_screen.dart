import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Student currentStudent;
  late ToeflScore toeflScore;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    currentStudent = Student(
      id: 1,
      name: 'YUDHISTIRA MAULANAA SAMARATUNGGA',
      studentId: '103012330011',
      email: 'yudhistira@telkomuniversity.ac.id',
    );

    toeflScore = ToeflScore.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingXLarge,
            vertical: AppDimensions.paddingXXLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student Profile Header
              StudentProfileHeader(
                student: currentStudent,
              ),
              const SizedBox(height: AppDimensions.marginXLarge),

              // TOEFL Status Card
              ToeflStatusCard(
                score: toeflScore,
              ),
              const SizedBox(height: AppDimensions.marginLarge),

              // Test History Section
              Container(
                padding: const EdgeInsets.only(
                  left: AppDimensions.paddingSmall,
                ),
                child: const Text(
                  AppStrings.testHistoryTitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppDimensions.fontSizeHuge,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.25,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.marginLarge),

              // Navigation
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: AppDimensions.marginMedium,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/tutorial_11_1');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(
                      AppDimensions.paddingMedium,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryBlue,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                    ),
                    child: const Text(
                      AppStrings.goToTutorial11,
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: AppDimensions.fontSizeLarge,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: AppDimensions.marginSmall,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/tutorial_12');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(
                      AppDimensions.paddingMedium,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                    ),
                    child: const Text(
                      AppStrings.goToTutorial12,
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: AppDimensions.fontSizeLarge,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
