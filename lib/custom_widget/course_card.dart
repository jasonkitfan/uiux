import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uiux/data/hd_data.dart';
import 'package:uiux/page/hd_detail_page.dart';

import '../data_manager/provider.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({Key? key, required this.category, required this.index})
      : super(key: key);

  final String category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<CourseDetailProvider>(context, listen: false).setCourse(
          higherDiplomaData[category][index]["title"],
          higherDiplomaData[category][index]["image"],
          higherDiplomaData[category][index]["code"],
          higherDiplomaData[category][index]["campus"],
          higherDiplomaData[category][index]["content"] ?? [],
          higherDiplomaData[category][index]["elective"] ?? {},
        );
        Navigator.pushNamed(
          context,
          HDDetailPage.route,
        );
      },
      child: Card(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                higherDiplomaData[category][index]["image"],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                          flex: 2,
                          child: Text(
                            "Title",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                          flex: 7,
                          child:
                              Text(higherDiplomaData[category][index]["title"]))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                          flex: 2,
                          child: Text(
                            "Code",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                          flex: 7,
                          child:
                              Text(higherDiplomaData[category][index]["code"]))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                          flex: 2,
                          child: Text(
                            "Campus",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                          flex: 7,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: higherDiplomaData[category][index]
                                      ["campus"]
                                  .length,
                              itemBuilder: (c, i) => Text(
                                  higherDiplomaData[category][index]["campus"]
                                      [i])))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
