import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/router/navigator.dart';
import 'package:graduation_project/router/routes.dart';
import '../blocs/patients_bloc.dart';
import '../widgets/patient_folder_card.dart';

class PatientsFoldersPage extends StatelessWidget {
  const PatientsFoldersPage({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<PatientsCubit>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                const SizedBox(width: 24),
                Expanded(child: Text("Patients List", style: AppTextStyles.w600.copyWith(fontSize: 30, color: AppColors.mainColor))),
                InkWell(
                  onTap: () => CustomNavigator.push(Routes.search),
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Hero(
                        tag: "search",
                        child: customImageIconSVG(
                          imageName: "search",
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: BlocBuilder<PatientsCubit, AppState>(
              builder: (context, state) {
                if (state is Done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          ...List.generate(
                            bloc.model.data!.patients.length,
                            (index) => PatientFolderCard(model: bloc.model.data!.patients[index]),
                          )
                        ],
                      ),
                    ),
                  );
                } else if (state is Loading) {
                  return Center(child: CircularProgressIndicator(color: AppColors.mainColor));
                } else if (state is Empty) {
                  return const SizedBox(
                    child: Center(child: Text("Empty")),
                  );
                } else {
                  return const Center(child: Text("Error"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
