import 'package:flutter/material.dart';
import 'package:graduation_project/componants/custom_arrow_back.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/router/navigator.dart';

import '../../../router/routes.dart';
import '../widgets/patient_info.dart';

class PatientDetailsPage extends StatelessWidget {
  const PatientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => CustomNavigator.pop(),
          child: Row(
            children: [
              const SizedBox(width: 24),
              ArrowBack(
                color: AppColors.mainColor,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        title: Text('Patient Details', style: AppTextStyles.w600.copyWith(fontSize: 18, color: AppColors.mainColor)),
        elevation: .2,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.more_vert),
        //     onPressed: () {},
        //     color: AppColors.mainColor,
        //   ),
        // ],
      ),
      body: SizedBox(
        width: MediaHelper.width,
        height: MediaHelper.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://www.w3schools.com/howto/img_avatar.png'),
              ),
              const SizedBox(height: 16),
              Text(
                'Mohamed Ali',
                style: AppTextStyles.w600.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 24),
              //==================================================================================================
              //==================================================================================================
              //==================================================================================================s
              Divider(height: 0, color: AppColors.mainColor.withOpacity(.2)),
              Row(
                children: [
                  Expanded(
                    child: PatientInfo(
                      label: "02-02-2021",
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customImageIconSVG(imageName: "calendar", color: AppColors.mainColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: PatientInfo(
                        label: "+20 1084236218",
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customImageIconSVG(imageName: "phone", color: AppColors.mainColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              PatientInfo(
                label: "mohamed.elhelbawy.ac@gmail.com",
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customImageIconSVG(imageName: "email", color: AppColors.mainColor),
                ),
              ),
              const SizedBox(height: 16),
              PatientInfo(
                label: "El-Mahalla El-Kubra, Gharbia, Egypt",
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customImageIconSVG(imageName: "location", color: AppColors.mainColor),
                ),
              ),
              const SizedBox(height: 16),
              Divider(height: 0, color: AppColors.mainColor.withOpacity(.2)),
              //==================================================================================================
              //==================================================================================================
              //==================================================================================================
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => CustomNavigator.push(Routes.patientNotes),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.mainColor.withOpacity(.1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customImageIconSVG(imageName: "notes", color: AppColors.mainColor, width: 32, height: 32),
                            const SizedBox(height: 4),
                            Text(
                              'Notes',
                              style: AppTextStyles.w500.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => CustomNavigator.push(Routes.patientAppointments),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.mainColor.withOpacity(.1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customImageIconSVG(imageName: "appointment_bold", color: AppColors.mainColor, width: 32, height: 32),
                            const SizedBox(height: 4),
                            Text(
                              'Appointmets',
                              style: AppTextStyles.w500.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.mainColor.withOpacity(.1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customImageIconSVG(imageName: "eye-scan", color: AppColors.mainColor, width: 32, height: 32),
                            const SizedBox(height: 4),
                            Text(
                              "Diseases",
                              style: AppTextStyles.w500.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
