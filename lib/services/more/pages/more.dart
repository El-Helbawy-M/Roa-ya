import 'package:flutter/material.dart';
import 'package:graduation_project/componants/custom_network_image.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/helpers/shared_helper.dart';
import '../widgets/more_option.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaHelper.width,
          height: MediaHelper.height,
          child: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.mainColor,
                  gradient: LinearGradient(colors: [AppColors.mainColor.withOpacity(.5), AppColors.mainColor]),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 1)],
                ),
                child: Row(
                  children: [
                    CustomNetworkImage.circleNewWorkImage(
                      image: "https://images.pexels.com/photos/5452268/pexels-photo-5452268.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                      radius: 36,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //UserBloc.instance.user!.user!.name ??
                        Text("Mohamed ali", style: AppTextStyles.w600.copyWith(fontSize: 20, color: Colors.white)),
                        const SizedBox(height: 4),
                        //UserBloc.instance.user!.user!.email ??
                        Text("mohamed.ali@gmil.com", style: AppTextStyles.w600.copyWith(fontSize: 16, color: AppColors.blaceHolderColor)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              MoreOption(label: "Edit Pofile", iconName: "edit_profile", onTap: () {}),
              MoreOption(label: "Notidicatoins", iconName: "notification", onTap: () {}),
              MoreOption(label: "Policies", iconName: "security", onTap: () {}),
              MoreOption(label: "Report Issue", iconName: "question", onTap: () {}),
              MoreOption(label: "Rate Us", iconName: "star", onTap: () {}),
              MoreOption(
                label: "Logout",
                iconName: "logout",
                onTap: () => SharedHelper().logout(),
                isLogout: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
