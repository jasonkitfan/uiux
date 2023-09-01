import 'package:flutter/material.dart';

import '../data/hd_data.dart';
import 'shared_preferences.dart';

class CourseDetailProvider extends ChangeNotifier {
  String? courseTitle;
  String? courseImage;
  String? courseCode;
  List<String>? courseCampus;
  List<List<String>>? courseContent;
  Map<String, dynamic>? courseElective;
  List searchResult = [];

  void setCourse(String title, String image, String code, List<String> campus,
      List<List<String>> content, Map<String, dynamic> elective) {
    courseTitle = title;
    courseImage = image;
    courseCode = code;
    courseCampus = campus;
    courseContent = content;
    courseElective = elective;
    notifyListeners();
    CourseSharedPreference()
        .setCourse(title, code, image, campus, content, elective);
  }

  void getCourse() async {
    final course = await CourseSharedPreference().getCourse();
    courseTitle = course.title;
    courseCode = course.code;
    courseImage = course.image;
    courseCampus = course.campus;
    courseContent = course.content;
    courseElective = course.elective;
    notifyListeners();
  }

  void searchCourse(String keywords) {
    if (keywords == "") {
      return;
    }

    searchResult.clear();
    higherDiplomaData.forEach((key, value) {
      value.forEach((course) {
        if (course["title"].toUpperCase().contains(keywords.toUpperCase())) {
          searchResult.add(course);
        }
      });
    });
  }
}
