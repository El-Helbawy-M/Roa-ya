import 'package:flutter/material.dart';

import '../../../componants/custom_icon.dart';
import '../../../componants/custom_network_image.dart';
import '../../../componants/shimmer/custom_shimmer.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomNetworkImage.containerNewWorkImage(
            width: 75,
            height: 75,
            radius: 15,
            fit: BoxFit.cover,
            image: "https://rewo.rw/wp-content/uploads/2022/03/7-77391_businessman-transparent-business-man-png.jpg",
          ),
          customImageIconSVG(imageName: "settings"),
        ]
      ),
    );
  }
}

class ProfileHeaderMock extends StatelessWidget {
  const ProfileHeaderMock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomShimmerContainer(height: 75,width: 75,),
          customImageIconSVG(imageName: "settings"),
        ]
      ),
    );
  }
}
