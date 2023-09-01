import 'package:flutter/material.dart';

import '../data_manager/provider.dart';
import '../global_function/func.dart';
import '../page/application_page.dart';

class CourseBasicInfo extends StatelessWidget {
  const CourseBasicInfo({
    super.key,
    required this.course,
  });

  final CourseDetailProvider course;

  @override
  Widget build(BuildContext context) {
    double width = getWidth(context);
    Responsive screenSize = responsive(width);

    List<Widget> children = [
      Image.asset(
        course.courseImage!,
        width: screenSize == Responsive.large ? width / 2.5 : double.infinity,
        fit: BoxFit.cover,
      ),
      const SizedBox(width: 20),
      Flexible(
        child: Column(
          mainAxisAlignment: screenSize == Responsive.large
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${course.courseTitle}",
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              overflow: TextOverflow.clip,
            ),
            const SizedBox(height: 20),
            Text(
              "${course.courseCode}",
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                const CourseIconLabel(
                    icon: Icons.access_time, labelText: "Duration: 2 years"),
                const SizedBox(height: 10),
                const CourseIconLabel(
                  icon: Icons.sunny,
                  labelText: "Mode: Full-time",
                ),
                const SizedBox(height: 10),
                CourseIconLabel(
                    icon: Icons.school_outlined,
                    labelText: "Campus: ${course.courseCampus?.join(", ")}")
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ApplicationPage.route,
                  );
                },
                child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      "Enroll",
                      style: TextStyle(fontSize: 30),
                    )))
          ],
        ),
      ),
    ];

    return Container(
        // height: screenSize == Responsive.large ? width / 3 : width / 0.5,
        padding: EdgeInsets.symmetric(horizontal: width / 10),
        width: double.infinity,
        color: Colors.black.withOpacity(0.8),
        child: screenSize == Responsive.large
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(children: children))
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
              ));
  }
}

class CourseIconLabel extends StatelessWidget {
  const CourseIconLabel({Key? key, required this.icon, required this.labelText})
      : super(key: key);

  final IconData icon;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
