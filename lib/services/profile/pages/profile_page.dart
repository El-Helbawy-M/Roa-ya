import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/componants/animated_widgets.dart';
import 'package:graduation_project/componants/custom_app_bar.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/componants/custom_network_image.dart';
import 'package:graduation_project/componants/shimmer/custom_shimmer.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/services/registration/bloc/user_bloc.dart';
import 'package:graduation_project/services/registration/models/user_model.dart';

import '../../../helpers/app_media_query.dart';
import '../../../network/shared_helper.dart';
import '../../../router/navigator.dart';
import '../../../router/routes.dart';
import '../widgets/more_option.dart';
import '../widgets/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaHelper.width,
          height: MediaHelper.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 24),
                CustomAppBar(
                  color: AppColors.mainColor,
                  title: "Profile",
                  suffixIcon: "setting_more",
                ),
                SizedBox(height: 24),
                Expanded(
                  child: BlocBuilder<UserBloc, AppState>(
                    builder: (context, state) {
                      if (state is Done) {
                        User model = UserBloc.instance.user!.user!;
                        return ListAnimator(
                          data: [
                            ProfileCard(model: model),
                            const SizedBox(height: 64),
                            Column(
                              children: [
                                MoreOption(
                                  title: "Logout",
                                  icon: 'logout',
                                  onTap: () {
                                    CustomNavigator.push(Routes.onboarding);
                                    return SharedHelper.sharedHelper!.logout();
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return CustomShimmer();
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
