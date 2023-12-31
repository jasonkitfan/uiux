import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_manager/provider.dart';
import 'content_expand.dart';
import 'elective_expand.dart';

class CourseContent extends StatefulWidget {
  const CourseContent({Key? key}) : super(key: key);

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  @override
  Widget build(BuildContext context) {
    var course = Provider.of<CourseDetailProvider>(context);

    // no content found in the data
    if (course.courseContent!.first.first == "") {
      return const SizedBox();
    }

    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width) /
              8,
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Curriculum",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Divider(color: Colors.black),
          const SizedBox(height: 20),
          ...List.generate(course.courseContent!.length,
              (index) => ContentExpand(semester: index)),
          const SizedBox(height: 40),
          if (course.courseElective!.keys.elementAt(0) != "N/A")
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Elective Module",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Divider(color: Colors.black),
                const SizedBox(height: 20),
                ...List.generate(
                    course.courseElective!.length,
                    (index) => ElectiveExpand(
                        title: course.courseElective!.keys.elementAt(index),
                        elective: course.courseElective![
                            course.courseElective!.keys.elementAt(index)]))
              ],
            )
        ],
      ),
    );
  }
}
