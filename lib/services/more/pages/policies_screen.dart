import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:graduation_project/componants/custom_arrow_back.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/router/navigator.dart';

import '../widgets/policies/term_card.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        leading: GestureDetector(
          onTap: () => CustomNavigator.pop(),
          child: const Padding(
            padding: EdgeInsets.only(left: 14, top: 16, bottom: 16),
            child: ArrowBack(color: Colors.white),
          ),
        ),
        title: Text("Policies", style: AppTextStyles.w500.copyWith(fontSize: 18, color: Colors.white)),
        elevation: 0,
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
                  (index) => TermCard(
                    index: index,
                    termText: "لوريم إيبسوم(Lorem Ipsum) هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
