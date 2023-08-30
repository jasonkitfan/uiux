import 'package:flutter/material.dart';
import 'dart:html' as html;

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// screen width checking
const double largeScreen = 1250;
const double mediumScreen = 700;

enum Responsive { large, medium, small }

Responsive responsive(double width) {
  if (width >= largeScreen) {
    return Responsive.large;
  } else if (width >= mediumScreen) {
    return Responsive.medium;
  } else {
    return Responsive.small;
  }
}

/// check windows platform for smooth scrolling
final userAgent = html.window.navigator.userAgent.toLowerCase();

bool isRunningOnWindow() {
  return userAgent.contains("win");
}
