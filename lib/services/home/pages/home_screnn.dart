import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/core/app_core.dart';
import 'package:graduation_project/core/app_notification.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/router/routes.dart';

import '../../../componants/custom_arrow_back.dart';
import '../../../router/navigator.dart';
import '../widgets/main_option_btn.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaHelper.width,
          height: MediaHelper.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Expanded(
                  child: MainOptionBtn(
                    title: "Scan",
                    iconName: "eye-scan",
                    onClick: () {},
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: MainOptionBtn(
                    title: "Upload",
                    iconName: "upload",
                    onClick: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        File file = File(result.files.single.path!);
                        AppCore.showSnackBar(
                            notification: AppNotification(
                                message: "The ${file.path} has been uploaded",backgroundColor: AppColors.active));
                        CustomNavigator.push(Routes.result);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
