import 'package:flutter/material.dart';
import 'package:graduation_project/helpers/app_media_query.dart';

import '../../../componants/custom_arrow_back.dart';
import '../../../componants/custom_button.dart';
import '../../../componants/custom_icon.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_text_styles.dart';
import '../../../router/navigator.dart';
import '../widgets/pick_date.dart';
import '../widgets/single_select_field.dart';

class AddAppointmentPage extends StatelessWidget {
  const AddAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaHelper.width,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(onTap: () => CustomNavigator.pop(), child: customImageIconSVG(imageName: "close-circle", color: AppColors.hint)),
              Expanded(
                child: Center(
                  child: Text(
                    "Add Appointment",
                    style: AppTextStyles.w600.copyWith(fontSize: 20, color: AppColors.mainColor),
                  ),
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
          const SizedBox(height: 24),
          const DateInputField(
            labelText: "Select Date",
          ),
          const SizedBox(height: 24),
          SingleSelectField(
            labelText: "Select Time",
            valueSet: [
              SelectOption(label: "08:00 AM", value: "08:00 AM"),
              SelectOption(label: "09:00 AM", value: "09:00 AM"),
              SelectOption(label: "10:00 AM", value: "10:00 AM"),
              SelectOption(label: "11:00 AM", value: "11:00 AM"),
            ],
          ),
          const SizedBox(height: 24),
          CustomBtn(
            text: "Add",
            onTap: () {},
            radius: 8,
            withPadding: false,
          )
        ],
      ),
    );
  }
}
