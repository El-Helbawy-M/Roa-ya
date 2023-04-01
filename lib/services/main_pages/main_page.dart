import 'package:flutter/material.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/services/home/pages/home_screen.dart';
import '../more/pages/more.dart';
import '../patients_folders/pages/patients_folders_list_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  PageController controller = PageController();
  List<Widget> screens = [
    const HomeScreen(),
    // const EmptyContainer(img: "soon_state", txt: "Comming soon!"),
    const PatientsFoldersPage(),
    const MorePage(),
  ];

  _goTo(int value) => (value - index == 1) || (value - index == -1) ? controller.animateToPage(value, duration: const Duration(milliseconds: 600), curve: Curves.easeIn) : controller.jumpToPage(value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaHelper.width,
        height: MediaHelper.height,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value) => setState(() {
                  index = value;
                }),
                physics: const BouncingScrollPhysics(),
                controller: controller,
                children: screens,
              ),
            ),
            Container(
              color: AppColors.mainColor,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavigationButton(
                      label: "Home",
                      iconName: "home",
                      isSelected: index == 0,
                      onTap: () {
                        _goTo(0);
                        setState(() => index = 0);
                      }),
                  BottomNavigationButton(
                      label: "Patient List",
                      iconName: "patients",
                      isSelected: index == 1,
                      onTap: () {
                        _goTo(1);
                        setState(() => index = 1);
                      }),
                  BottomNavigationButton(
                      label: "More",
                      iconName: "more",
                      isSelected: index == 2,
                      onTap: () {
                        _goTo(2);
                        setState(() => index = 2);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationButton extends StatelessWidget {
  const BottomNavigationButton({
    Key? key,
    this.isSelected = false,
    required this.label,
    required this.iconName,
    required this.onTap,
  }) : super(key: key);
  final bool isSelected;
  final String label, iconName;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: isSelected ? 100 : 48,
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: isSelected ? Colors.white : AppColors.mainColor),
        child: Row(
          children: [
            const SizedBox(width: 14),
            customImageIconSVG(width: 18, height: 18, imageName: iconName, color: isSelected ? AppColors.mainColor : Colors.white),
            Expanded(
              child: Center(
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 800),
                  firstChild: Text(label, style: AppTextStyles.w600.copyWith(fontSize: 12, color: AppColors.mainColor)),
                  crossFadeState: isSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  secondChild: SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
