import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_manager/provider.dart';
import 'page/application_page.dart';
import 'page/hd_detail_page.dart';
import 'page/hd_page.dart';
import 'page/search_result_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CourseDetailProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Lato"),
      initialRoute: HDPage.route,
      routes: {
        HDPage.route: (context) => const HDPage(),
        HDDetailPage.route: (context) => const HDDetailPage(),
        SearchResultPage.route: (context) => const SearchResultPage(),
        ApplicationPage.route: (context) => const ApplicationPage(),
      },
    );
  }
}
