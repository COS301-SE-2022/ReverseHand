// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/job_icons.dart';
import 'package:general/methods/time.dart';

// import 'package:redux/redux.dart'; // uncommment when tests are implemented

void main() {
  test("getIcon unit test", () {
    expect(Icons.plumbing, getIcon("Plumbing"));
    expect(Icons.design_services, getIcon("Designer"));
    expect(Icons.carpenter, getIcon("Carpenter"));
    expect(Icons.park, getIcon("Landscaper"));
    expect(Icons.imagesearch_roller, getIcon("Painting"));
    expect(Icons.cleaning_services, getIcon("Cleaner"));
    expect(Icons.grid_view, getIcon("Tiler"));
    expect(Icons.bolt, getIcon("Electrician"));
  });

  var timestamp = 1662987291649.0;

  test("timestampToDate() method unit test", () {
    expect("12-09-2022", timestampToDate(timestamp));
  });
}
