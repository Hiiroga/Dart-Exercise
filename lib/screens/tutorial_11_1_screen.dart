import 'package:flutter/material.dart';
import '../constants/constants.dart';

class Tutorial11_1Screen extends StatefulWidget {
  const Tutorial11_1Screen({Key? key}) : super(key: key);

  @override
  State<Tutorial11_1Screen> createState() => _Tutorial11_1ScreenState();
}

class _Tutorial11_1ScreenState extends State<Tutorial11_1Screen> {
  late PageController pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ABP Minggu 11'),
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                children: [
                  // Home Page
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(
                          AppDimensions.paddingLarge,
                        ),
                        margin: const EdgeInsets.all(
                          AppDimensions.marginLarge,
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
                          AppStrings.homePageText,
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: AppDimensions.fontSizeLarge,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Email Page (Tutorial 11-2 content)
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/tutorial_11_2');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(
                          AppDimensions.paddingLarge,
                        ),
                        margin: const EdgeInsets.all(
                          AppDimensions.marginLarge,
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
                          'Go to Tutorial 11-2 (ListView)',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: AppDimensions.fontSizeLarge,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Profile Page
                  const Center(
                    child: Text(
                      AppStrings.profilePageTitle,
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: AppDimensions.fontSizeXXLarge,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.primaryBlue,
              selectedItemColor: AppColors.successGreen,
              unselectedItemColor: AppColors.backgroundWhite,
              currentIndex: selectedIndex,
              onTap: (index) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear,
                );
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: AppStrings.homeTabLabel,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.email),
                  label: AppStrings.emailTabLabel,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: AppStrings.profileTabLabel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
