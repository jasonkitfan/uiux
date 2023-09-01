import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_widget/course_basic_info.dart';
import '../custom_widget/course_category.dart';
import '../custom_widget/course_content.dart';
import '../custom_widget/course_entrance_requirement.dart';
import '../custom_widget/my_app_bar.dart';
import '../data_manager/provider.dart';
import '../global_function/func.dart';

class HDDetailPage extends StatefulWidget {
  const HDDetailPage({Key? key}) : super(key: key);

  static const route = "/details";

  @override
  State<HDDetailPage> createState() => _HDDetailPageState();
}

class _HDDetailPageState extends State<HDDetailPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  double offset = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => Provider.of<CourseDetailProvider>(context, listen: false)
            .getCourse());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var course = Provider.of<CourseDetailProvider>(context);
    double width = getWidth(context);

    // show loading if user refresh the page
    if (course.courseImage == null) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: const Color(0xff7874ff),
          automaticallyImplyLeading: false,
          title: MyAppBar(
            scaffoldKey: scaffoldKey,
          ),
        ),
        body: const Center(
          child: SizedBox(
              width: 100, height: 100, child: CircularProgressIndicator()),
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: SizedBox(width: width * 2 / 3, child: const CourseCategory()),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xff7874ff),
        automaticallyImplyLeading: false,
        title: MyAppBar(
          scaffoldKey: scaffoldKey,
        ),
      ),
      body: !isRunningOnWindow()
          ? body(course, width, null)
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
                child: body(course, width, _scrollController),
              ),
            ),
    );
  }
}

Widget body(var course, double width, ScrollController? controller) {
  return SingleChildScrollView(
    controller: controller,
    physics: isRunningOnWindow() ? const NeverScrollableScrollPhysics() : null,
    child: Column(
      children: [
        CourseBasicInfo(course: course),
        const SizedBox(height: 50),
        const CourseContent(),
        const SizedBox(height: 50),
        const CourseEntranceRequirement(),
        const SizedBox(height: 50),
      ],
    ),
  );
}
