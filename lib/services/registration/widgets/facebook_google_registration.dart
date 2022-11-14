import 'package:flutter/material.dart';

import '../../../componants/custom_button.dart';
import '../../../componants/custom_icon.dart';
import '../../../core/localization.dart';
import '../../../helpers/app_colors.dart';

class FacebookGoogleRegistration extends StatelessWidget {
  const FacebookGoogleRegistration({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBtn(
          isCentered: false,
          image: customImageIconSVG(imageName: "facebook"),
          text: getLang("log in with facebook"),
          onTap: () {},
          btnHeight: 55,
          txtColor: AppColors.mainColor,
          radius: 15,
          onlyBorder: true,
          showTransparent: true,
          withPadding: false,
        ),
        const SizedBox(height: 24),
        CustomBtn(
          isCentered: false,
          image: SizedBox(
              width: 24,
              height: 24,
              child: customImageIconSVG(imageName: "google")),
          text: getLang("log in with google"),
          onTap: () {},
          btnHeight: 55,
          txtColor: AppColors.mainColor,
          radius: 15,
          onlyBorder: true,
          showTransparent: true,
          withPadding: false,
        ),
      ],
    );
  }
}
