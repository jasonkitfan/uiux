import 'package:flutter/material.dart';

import '../global_function/func.dart';
import '../page/hd_page.dart';
import 'my_search_bar.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    double width = getWidth(context);
    Responsive screenSize = responsive(width);

    return Row(
      children: [
        if (screenSize != Responsive.large)
          GestureDetector(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: const Icon(Icons.menu_outlined)),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              HDPage.route,
            );
          },
          child: Text(
            "VTC",
            style: TextStyle(
                fontSize: screenSize == Responsive.large
                    ? 50
                    : screenSize == Responsive.medium
                        ? 30
                        : 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
        const Spacer(),
        const MySearchBar(),
        const Spacer(),
        screenSize == Responsive.large
            ? Row(
                children: [
                  const Icon(Icons.language_outlined),
                  const SizedBox(width: 20),
                  const Text("FAQ"),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {},
                      child: const Text("Contact"))
                ],
              )
            : GestureDetector(
                onTap: () {
                  showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(1, 0, 0, 0),
                      items: [
                        const PopupMenuItem(child: Text("Language")),
                        const PopupMenuItem(child: Text("FAQ")),
                        const PopupMenuItem(child: Text("Contact"))
                      ]);
                },
                child: const Icon(Icons.more_vert))
      ],
    );
  }
}
