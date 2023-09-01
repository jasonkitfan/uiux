import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_widget/course_category.dart';
import '../custom_widget/my_app_bar.dart';
import '../data_manager/provider.dart';
import '../global_function/func.dart';
import 'hd_detail_page.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  static const route = "/search_result";

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double offset = 0;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = getWidth(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xff7874ff),
        automaticallyImplyLeading: false,
        title: MyAppBar(
          scaffoldKey: scaffoldKey,
        ),
      ),
      drawer: SizedBox(width: width * 2 / 3, child: const CourseCategory()),
      body: !isRunningOnWindow()
          ? const Body()
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
                child: Body(controller: _scrollController),
              ),
            ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key, this.controller}) : super(key: key);

  final ScrollController? controller;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var result =
        Provider.of<CourseDetailProvider>(context, listen: false).searchResult;

    return SingleChildScrollView(
      controller: widget.controller,
      physics:
          isRunningOnWindow() ? const NeverScrollableScrollPhysics() : null,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 600,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: result.length,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Provider.of<CourseDetailProvider>(context, listen: false)
                          .setCourse(
                        result[index]["title"],
                        result[index]["image"],
                        result[index]["code"],
                        result[index]["campus"],
                        result[index]["content"],
                        result[index]["elective"],
                      );
                      Navigator.pushNamed(context, HDDetailPage.route);
                    },
                    child: SizedBox(
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                                child: Image.asset(result[index]["image"])),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    result[index]["title"],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    result[index]["code"],
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    result[index]["campus"].join(", "),
                                    style: const TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
