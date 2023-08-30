import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uiux/custom_widget/course_category.dart';
import 'package:uiux/custom_widget/course_section.dart';
import 'package:uiux/custom_widget/hd_banner.dart';
import 'package:uiux/custom_widget/my_app_bar.dart';
import 'package:uiux/global_function/func.dart';

class HDPage extends StatefulWidget {
  const HDPage({Key? key}) : super(key: key);

  static const route = "/higher_diploma";

  @override
  State<HDPage> createState() => _HDPageState();
}

class _HDPageState extends State<HDPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  double offset = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = getWidth(context);
    Responsive screenSize = responsive(width);

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: MyAppBar(
            scaffoldKey: scaffoldKey,
          ),
        ),
        drawer: SizedBox(width: width * 2 / 3, child: const CourseCategory()),
        body: !isRunningOnWindow()
            ? body(screenSize, width, null)
            : Listener(
                onPointerSignal: (signal) {
                  if (signal is PointerScrollEvent) {
                    offset += signal.scrollDelta.dy;
                    _scrollController.animateTo(offset,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear);
                  }
                },
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollEndNotification) {
                      offset = _scrollController.offset;
                    }
                    return true;
                  },
                  child: body(screenSize, width, _scrollController),
                ),
              ));
  }
}

Widget body(Responsive screenSize, double width, ScrollController? controller) {
  return Stack(
    children: <Widget>[
      SingleChildScrollView(
        controller: controller,
        physics:
            isRunningOnWindow() ? const NeverScrollableScrollPhysics() : null,
        child: Padding(
          padding: screenSize == Responsive.large
              ? EdgeInsets.only(left: width * 2 / 10)
              : EdgeInsets.zero,
          child: Column(
            children: const [
              HDBanner(),
              SizedBox(height: 50),
              CourseSection(category: "Health and Life Sciences"),
              SizedBox(height: 50),
              CourseSection(category: "Business"),
            ],
          ),
        ),
      ),
      if (screenSize == Responsive.large)
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          child: SizedBox(
            width: width * 2 / 10, // Set the width as per your requirement
            child: const CourseCategory(),
          ),
        ),
    ],
  );
}
