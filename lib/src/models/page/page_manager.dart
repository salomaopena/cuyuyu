// @dart=2.9
import 'package:flutter/material.dart';

class PageManager {
  PageManager(this._pageController);

  final PageController _pageController;
  int page = 0;

  void setPage(int value) {
    if (page == value) {
      return;
    }
    page = value;
    _pageController.jumpToPage(value);
  }
}
