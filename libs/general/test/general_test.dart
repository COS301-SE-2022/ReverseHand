// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/job_icons.dart';

// import 'package:redux/redux.dart'; // uncommment when tests are implemented

void main() {
  test("getIcon unit test", () {
    expect(Icons.bolt, getIcon("Electrician"));
    expect(Icons.plumbing, getIcon("Plumber"));

    expect(Icons.sanitizer, getIcon("Cleaner"));
    expect(Icons.carpenter, getIcon("Carpenter"));

    expect(Icons.design_services, getIcon("Designer"));
  });
}
