import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uiux/data_manager/provider.dart';
import 'package:uiux/global_function/func.dart';
import 'package:uiux/page/search_result_page.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key}) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  String input = "";

  void startSearching() {
    Provider.of<CourseDetailProvider>(context, listen: false)
        .searchCourse(input);
    Navigator.pushNamed(context, SearchResultPage.route);
  }

  @override
  Widget build(BuildContext context) {
    double width = getWidth(context);
    return SizedBox(
      width: width / 2.5,
      height: 40,
      child: TextFormField(
        autocorrect: false,
        decoration: InputDecoration(
          isDense: true,
          hintText: "Course Title",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0), // Set the border radius
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: GestureDetector(
            onTap: () => startSearching(),
            child: const Icon(Icons.search),
          ),
        ),
        onChanged: (value) {
          input = value;
        },
        onEditingComplete: () {
          startSearching();
        },
      ),
    );
  }
}
