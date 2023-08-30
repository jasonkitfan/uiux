import 'package:flutter/material.dart';
import 'package:uiux/custom_widget/course_card.dart';
import 'package:uiux/data/hd_data.dart';
import 'package:uiux/global_function/func.dart';

class CourseSection extends StatelessWidget {
  const CourseSection({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    Responsive screenSize = responsive(getWidth(context));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
        ),
        const SizedBox(height: 50),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: screenSize == Responsive.large
                  ? 1 / 1.1
                  : screenSize == Responsive.medium
                      ? 1 / 1.05
                      : 1 / 0.9,
              crossAxisCount: screenSize == Responsive.large
                  ? 3
                  : screenSize == Responsive.medium
                      ? 2
                      : 1),
          itemCount: higherDiplomaData[category].length,
          itemBuilder: (BuildContext context, int index) =>
              CourseCard(category: category, index: index),
        ),
      ],
    );
  }
}
