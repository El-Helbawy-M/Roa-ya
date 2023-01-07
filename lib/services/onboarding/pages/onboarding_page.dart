import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:graduation_project/componants/animated_widgets.dart';
import 'package:graduation_project/componants/custom_button.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/router/navigator.dart';
import 'package:graduation_project/router/routes.dart';
import 'package:graduation_project/services/onboarding/models/content_model.dart';

import '../../../helpers/app_media_query.dart';
import '../widgets/animated_page_indicator.dart';
import '../widgets/blank_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int index = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final ContentModel contentModel = ContentModel();
    return Scaffold(
      body: SizedBox(
        width: MediaHelper.width,
        height: MediaHelper.height,
        child: Stack(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                width: MediaHelper.width,
                height: MediaHelper.height * .5,
                color: const Color(0xff454CFF),
              ),
            ),
            SafeArea(
              child: SizedBox(
                width: MediaHelper.width,
                height: MediaHelper.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Expanded(
                        child: PageView(
                          onPageChanged: (value) => setState(() {
                            index = value;
                          }),
                          controller: controller,
                          children: List.generate(
                            contentModel.titles.length,
                            (index) => ListAnimator(
                              data: [
                                SizedBox(height: (MediaHelper.height / 2) / 5),
                                Center(
                                  child: SizedBox(
                                    height: 60,
                                    width: 226,
                                    child: customImageIcon(
                                      imageName: "logo",
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 36),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Because we",
                                      style: AppTextStyles.w300.copyWith(fontSize: 16, color: Colors.white),
                                      children: [
                                        TextSpan(
                                          text: " Care",
                                          style: AppTextStyles.w700.copyWith(fontSize: 16, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 70),
                                Column(
                                  children: const [
                                    BlankWidget(
                                      height: 19,
                                      width: 125,
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    BlankWidget(
                                      height: 6,
                                      width: 39,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 125),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      contentModel.titles[index],
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.w500.copyWith(fontSize: 24),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      contentModel.values[index],
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.w300.copyWith(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            contentModel.titles.length,
                            (value) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.5),
                                  child: AnimatedPageIndicatorOnboarding(check: index == value),
                                )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomBtn(
                        text: index == contentModel.titles.length - 1 ? "Get Started" : "Next",
                        onTap: () {
                          if (index == contentModel.titles.length - 1) {
                            CustomNavigator.push(Routes.login);
                          } else {
                            index++;
                            controller.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        btnHeight: 64,
                        txtFontSize: 24,
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              index = contentModel.titles.length - 1;
                              controller.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeIn,
                              );
                            });
                          },
                          child: AnimatedCrossFade(
                            crossFadeState: !(index == contentModel.titles.length - 1) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                            duration: Duration(milliseconds: 400),
                            secondChild: const SizedBox(height: 0),
                            firstChild: Text(
                              "Skip",
                              style: AppTextStyles.w600.copyWith(fontSize: 16, color: AppColors.greyText),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
