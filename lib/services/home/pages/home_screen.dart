import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/services/home/blocs/latest_appoinments_bloc.dart';
import 'package:graduation_project/services/home/widgets/section_title.dart';
import 'package:graduation_project/services/registration/bloc/user_bloc.dart';
import '../widgets/comming_appoinments.dart';
import '../widgets/mock_page.dart';
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
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      child: RichText(
                        text: TextSpan(
                          text: "Good Morning",
                          children: [TextSpan(text: "\nDr.${UserBloc.instance.user!.data!.user!.name} 👋", style: AppTextStyles.w500.copyWith(fontSize: 20))],
                          style: AppTextStyles.w300.copyWith(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ),
                    QuickActionsPanel(),
                    const Padding(
                      padding: EdgeInsets.only(left: 24, right: 24, top: 36, bottom: 16),
                      child: SectionTitle(title: "Comming Appointments"),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: CommingAppoinments(),
                    ),
                  ],
                ),
              );
            } else {
              return HomeMockPage();
            }
          }),
        ),
      ),
    );
  }
}
