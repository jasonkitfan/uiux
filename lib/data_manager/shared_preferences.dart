import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CourseSharedPreference {
  final courseTitle = "title";
  final courseCode = "code";
  final courseImage = "image";
  final courseCampus = "campus";
  final courseContent = "content";
  final semester = "semester";
  final elective = "elective";

  void setCourse(String title, String code, String image, List<String> campus,
      List<List<String>> content, Map<String, dynamic>? data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final sem = content.length;
    prefs.setString(courseTitle, title);
    prefs.setString(courseCode, code);
    prefs.setString(courseImage, image);
    prefs.setStringList(courseCampus, campus);

    prefs.setInt(semester, sem);
    for (var n in Iterable.generate(sem)) {
      prefs.setStringList("${semester}_$n", content[n]);
    }

    if (data != null) {
      storeDictionaryData(data);
    }
  }

  Future<CourseDetailModel> getCourse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final title = prefs.getString(courseTitle);
    final code = prefs.getString(courseCode);
    final image = prefs.getString(courseImage);
    final campus = prefs.getStringList(courseCampus);
    final sem = prefs.getInt(semester)!;
    List<List<String>> s = [];
    for (var n in Iterable.generate(sem)) {
      s.add(prefs.getStringList("${semester}_$n")!);
    }

    final ele = await retrieveDictionaryData();

    final course = CourseDetailModel(
        title: title!,
        code: code!,
        image: image!,
        campus: campus!,
        content: s,
        elective: ele);
    return course;
  }

  // Storing dictionary data (map) in SharedPreferences
  Future<void> storeDictionaryData(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(data);
    await prefs.setString(elective, jsonString);
  }

// Retrieving dictionary data (map) from SharedPreferences
  Future<Map<String, dynamic>> retrieveDictionaryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString(elective) ?? '';
    if (jsonString.isEmpty) {
      return {}; // Return an empty map if no data is found
    }
    return json.decode(jsonString);
  }
}

class CourseDetailModel {
  String title;
  String code;
  String image;
  List<String> campus;
  List<List<String>> content;
  Map<String, dynamic> elective;

  CourseDetailModel(
      {required this.title,
      required this.code,
      required this.image,
      required this.campus,
      required this.content,
      required this.elective});
}
