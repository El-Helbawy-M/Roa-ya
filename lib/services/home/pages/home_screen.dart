import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/componants/animated_widgets.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/componants/custom_network_image.dart';
import 'package:graduation_project/componants/shimmer/custom_shimmer.dart';
import 'package:graduation_project/core/app_core.dart';
import 'package:graduation_project/core/app_notification.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/router/routes.dart';
import 'package:graduation_project/services/home/widgets/search_bar.dart';
import 'package:graduation_project/services/home/widgets/section_title.dart';
import 'package:graduation_project/services/registration/bloc/user_bloc.dart';
import 'package:graduation_project/services/registration/models/user_model.dart';

import '../../../componants/custom_arrow_back.dart';
import '../../../router/navigator.dart';
import '../widgets/latest_results_panel.dart';
import '../widgets/main_option_btn.dart';
import '../widgets/mock_page.dart';
import '../widgets/profile_header.dart';
import '../widgets/quick_actions_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaHelper.width,
          height: MediaHelper.height,
          child: BlocBuilder<UserBloc, AppState>(builder: (context, state) {
            if (state is Done) {
              return ListAnimator(
                data: [
                  const SizedBox(height: 24),
                  const ProfileHeader(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        text: "Good Morning",
                        children: [TextSpan(text: "\nDr.${UserBloc.instance.user!.user!.name} 👋", style: AppTextStyles.w500.copyWith(fontSize: 20))],
                        style: AppTextStyles.w300.copyWith(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: SearchBar(goingDown: false),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 36, bottom: 24),
                    child: SectionTitle(title: "Quick Actions"),
                  ),
                  QuickActionsPanel(),
                  const Padding(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 36, bottom: 24),
                    child: SectionTitle(title: "Latest Results"),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal:24),
                    child: LatestResultsPanel(),
                  ),
                ],
              );
            } else {
              return  HomeMockPage();
            }
          }),
        ),
      ),
    );
  }
}

