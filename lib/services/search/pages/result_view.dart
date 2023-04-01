import 'package:flutter/material.dart';

import '../../patients_folders/widgets/patient_folder_card.dart';

class ResultView extends StatelessWidget {
  const ResultView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 16),
            ...List.generate(
              8,
              (index) => Container(),
            )
          ],
        ),
      ),
    );
  }
}
