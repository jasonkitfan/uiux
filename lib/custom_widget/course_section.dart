import 'package:flutter/material.dart';

import '../data/hd_data.dart';
import '../global_function/func.dart';
import 'course_card.dart';

class CourseSection extends StatelessWidget {
  const CourseSection({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    double width = getWidth(context);
    Responsive screenSize = responsive(width);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(0xff7874ff).withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100))),
          padding: const EdgeInsets.all(20),
          child: Text(
            category,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenSize == Responsive.large
                    ? 50
                    : screenSize == Responsive.medium
                        ? 40
                        : 30),
          ),
        ),
        const SizedBox(height: 50),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: width / width * 0.8,
              crossAxisCount: screenSize == Responsive.large
                  ? 4
                  : screenSize == Responsive.medium
                      ? 3
                      : 2),
          itemCount: higherDiplomaData[category].length,
          itemBuilder: (BuildContext context, int index) =>
              CourseCard(category: category, index: index),
        ),
      ],
    );
  }
}
