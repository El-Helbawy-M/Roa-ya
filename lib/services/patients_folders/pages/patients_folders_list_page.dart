import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/componants/custom_network_image.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';

import '../widgets/patient_folder_card.dart';
import '../widgets/search_bar.dart';

class PatientsFoldersPage extends StatelessWidget {
  const PatientsFoldersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.mainColor,
          height: 160,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),
              Text("Patients List", style: AppTextStyles.w600.copyWith(fontSize: 20, color: Colors.white)),
              const SizedBox(height: 16),
              const SearchBar(),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  ...List.generate(
                    6,
                    (index) => PatientFolderCard(),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
