import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_events.dart';
import 'package:graduation_project/services/search/blocs/recent_keyword_cubit.dart';
import 'package:graduation_project/services/search/blocs/search_bloc.dart';

import '../../../helpers/app_colors.dart';

class RecentSearchWordView extends StatelessWidget {
  const RecentSearchWordView({super.key, this.onSelect, required this.word});
  final String word;
  final Function(String)? onSelect;
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<RecentKeywordCubit>(context);
    return InkWell(
      onTap: () {
        BlocProvider.of<SearchBloc>(context).add(GetData(arguments: word));
        onSelect != null ? onSelect!(word) : null;
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                Expanded(child: Text(word)),
                InkWell(
                  onTap: () => bloc.remove(word),
                  borderRadius: BorderRadius.circular(50),
                  child: Icon(
                    Icons.close,
                    color: AppColors.blaceHolderColor,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0)
        ],
      ),
    );
  }
}
