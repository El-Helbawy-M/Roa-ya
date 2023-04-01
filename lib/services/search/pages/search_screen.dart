import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/componants/custom_arrow_back.dart';
import 'package:graduation_project/componants/empty_container.dart';
import 'package:graduation_project/core/app_events.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/router/navigator.dart';
import 'package:graduation_project/services/home/widgets/search_bar.dart';
import 'package:graduation_project/services/search/blocs/recent_keyword_cubit.dart';
import 'package:graduation_project/services/search/blocs/search_bloc.dart';
import 'package:graduation_project/services/search/pages/result_view.dart';
import 'package:graduation_project/services/search/pages/start_view.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? timer;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<SearchBloc>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaHelper.width,
          height: MediaHelper.height,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      GestureDetector(onTap: () => CustomNavigator.pop(), child: ArrowBack(color: AppColors.mainColor)),
                      Expanded(
                        child: SearchBar(
                          goingDown: false,
                          controller: controller,
                          onChanged: (value) {
                            if (timer != null) {
                              if (timer!.isActive) {
                                timer!.cancel();
                              }
                            }
                            timer = Timer(
                              const Duration(milliseconds: 600),
                              () {
                                BlocProvider.of<RecentKeywordCubit>(context).update(value);
                                bloc.add(GetData(arguments: value));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0),
                Expanded(
                  child: BlocBuilder<SearchBloc, AppState>(
                    builder: (context, state) {
                      if (state is Start) {
                        return StartView(
                          onSelect: (value) {
                            controller.text = value;
                            setState(() {});
                          },
                        );
                      } else if (state is Empty) {
                        return const EmptyContainer(
                          img: "assets/images/empty_search.png",
                          txt: "No Results",
                          isSvg: false,
                          subText: "No data for what you are searching for!",
                        );
                      } else if (state is Done) {
                        return const ResultView();
                      } else if (state is Loading) {
                        return Lottie.asset("assets/animations/searching.json", fit: BoxFit.contain);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
