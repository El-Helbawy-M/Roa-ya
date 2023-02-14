import 'package:flutter/material.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';

import '../componants/custom_button.dart';
import '../componants/custom_icon.dart';
import '../router/navigator.dart';

class ErrorHandler {
  String title, message;
  String? iconName;
  ErrorHandler({required this.title, required this.message, this.iconName});
  void showDefaultErrorMessage() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return WillPopScope(
              onWillPop: () async => true,
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: SimpleDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 3,
                    titlePadding: const EdgeInsets.all(0),
                    contentPadding: const EdgeInsets.all(0),
                    title: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        color: AppColors.mainColor,
                      ),
                      child: Row(children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: customImageIconSVG(imageName: iconName ?? 'info', color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          title,
                          style: AppTextStyles.w600.copyWith(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    ),
                    children: [
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(message, style: AppTextStyles.w500.copyWith(fontSize: 14, color: AppColors.subHeader)),
                      ),
                      const SizedBox(height: 36),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomBtn(
                                text: 'Ok',
                                onTap: () {
                                  CustomNavigator.pop();
                                },
                                btnWidth: 100,
                                color: AppColors.mainColor.withOpacity(.1),
                                radius: 13,
                                txtColor: AppColors.mainColor),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ));
        },
        transitionDuration: const Duration(milliseconds: 300),
        barrierLabel: '',
        context: CustomNavigator.navigatorState.currentContext!,
        // ignore: missing_return
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}
