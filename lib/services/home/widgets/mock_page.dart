import 'package:flutter/material.dart';
import 'package:graduation_project/services/home/widgets/profile_header.dart';
import 'package:graduation_project/services/home/widgets/quick_actions_panel.dart';
import 'package:graduation_project/services/home/widgets/search_bar.dart';
import 'package:graduation_project/services/home/widgets/section_title.dart';

import '../../../componants/animated_widgets.dart';
import '../../../componants/shimmer/custom_shimmer.dart';
import 'latest_results_panel.dart';

class HomeMockPage extends StatelessWidget {
  const HomeMockPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListAnimator(data: [
        const SizedBox(height: 24),
        const ProfileHeaderMock(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomShimmerText(width: 100),
              SizedBox(height: 8,),
              CustomShimmerText(width: 150),
            ],
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
          child: LatestResultsPanelMock(),
        ),
      ]),
    );
  }
}

