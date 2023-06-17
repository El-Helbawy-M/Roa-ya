import 'package:flutter/material.dart';
import 'package:graduation_project/componants/custom_arrow_back.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/services/add_note/pages/add_note_page.dart';

import '../../../router/navigator.dart';
import '../widgets/note_card.dart';

class PatientNotesPage extends StatelessWidget {
  const PatientNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Patient Notes",
          style: AppTextStyles.w600.copyWith(fontSize: 18, color: AppColors.mainColor),
        ),
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
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: .2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            ),
            builder: (context) => const AddNotePage(),
          );
        },
        backgroundColor: AppColors.mainColor,
        child: const Icon(Icons.add),
      ),
      body: SizedBox(
        width: MediaHelper.width,
        height: MediaHelper.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 24),
                ...List.generate(
                  5,
                  (index) => const NoteCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
