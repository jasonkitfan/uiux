import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uiux/data_manager/provider.dart';

class ContentExpand extends StatefulWidget {
  const ContentExpand({Key? key, required this.semester}) : super(key: key);

  final int semester;

  @override
  State<ContentExpand> createState() => _ContentExpandState();
}

class _ContentExpandState extends State<ContentExpand> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    var course = Provider.of<CourseDetailProvider>(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              expand = !expand;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                border: Border.all(color: Colors.grey)),
            child: Row(
              children: [
                AnimatedRotation(
                  turns: expand ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    Icons.expand_circle_down_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  "Semester ${widget.semester + 1}",
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const Spacer(),
                Text(
                  "${course.courseContent![widget.semester].length} Subjects",
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          duration: const Duration(seconds: 1),
          height:
              expand ? course.courseContent![widget.semester].length * 50 : 0,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                    course.courseContent![widget.semester].length,
                    (index) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        color: index % 2 == 0
                            ? Colors.grey.withOpacity(0.4)
                            : Colors.grey.withOpacity(0.2),
                        height: 50,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(course.courseContent![widget.semester]
                                [index]))))
              ],
            ),
          ),
        )
      ],
    );
  }
}
