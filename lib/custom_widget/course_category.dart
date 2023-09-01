import 'package:flutter/material.dart';

class CourseCategory extends StatelessWidget {
  const CourseCategory({Key? key}) : super(key: key);

  final List s6Category = const [
    "Degree",
    "Higher Diploma",
    "Diploma of Foundation Studies",
    "Diploma of Vocational Education",
    "Diploma"
  ];

  final List category = const [
    "S6 Full Time",
    "S3 Full Time",
    "Part-time",
    "Higher Diploma Graduates",
    "Non-Local Students"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const Divider(thickness: 2),
          ListView.builder(
              shrinkWrap: true,
              itemCount: category.length,
              itemBuilder: (context, index) => CategoryButton(
                    category: category[index],
                    categoryIndex: index,
                    color: category[index] == "S6 Full Time"
                        ? Colors.indigoAccent
                        : null,
                  )),
          const SizedBox(height: 20),
          const Text(
            "Course",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const Divider(thickness: 2),
          ListView.builder(
              shrinkWrap: true,
              itemCount: s6Category.length,
              itemBuilder: (context, index) => CategoryButton(
                    category: s6Category[index],
                    categoryIndex: index,
                    color: s6Category[index] == "Higher Diploma"
                        ? Colors.indigoAccent
                        : null,
                  ))
        ],
      ),
    );
  }
}

class CategoryButton extends StatefulWidget {
  const CategoryButton(
      {Key? key,
      required this.category,
      required this.categoryIndex,
      this.color})
      : super(key: key);

  final String category;
  final int categoryIndex;
  final Color? color;

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          backgroundColor = Colors.grey;
        });
      },
      onExit: (_) {
        setState(() {
          backgroundColor = Theme.of(context).scaffoldBackgroundColor;
        });
      },
      child: GestureDetector(
        onTap: () {
          // print("${widget.categoryIndex} is pressed");
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          color: widget.color?.withOpacity(0.4) ?? backgroundColor,
          child: Text(
            widget.category,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
