import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/services/search/blocs/recent_keyword_cubit.dart';

import '../../../helpers/app_colors.dart';
import '../../../helpers/app_text_styles.dart';
import '../widgets/recent_search_word_view.dart';

class StartView extends StatelessWidget {
  const StartView({super.key, this.onSelect});
  final Function(String)? onSelect;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentKeywordCubit, AppState>(
      builder: (context, state) {
        if (state is Done) {
          List<String> words = state.list as List<String>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Recent Search",
                  style: AppTextStyles.w600.copyWith(fontSize: 18, color: AppColors.titleMediumColor),
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(
                words.length,
                (index) => RecentSearchWordView(
                  word: words[index],
                  onSelect: onSelect,
                ),
              ),
            ],
          );
        } else if (state is Empty) {
          return const SizedBox();
        } else if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
