import 'package:flutter/material.dart';

final Map<String, IconData> domains = {
  'Plumber': Icons.plumbing,
  'Designer': Icons.design_services,
  'Carpenter': Icons.carpenter,
  'Landscaper': Icons.abc, //still need an icon
  'Painting': Icons.imagesearch_roller,
  'Cleaner': Icons.sanitizer,
  'Tiler': Icons.abc, //still need an icon
  'Electrician': Icons.bolt
};

IconData? getIcon(String adType) {
  return domains[adType];
}
