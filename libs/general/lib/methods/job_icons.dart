import 'package:flutter/material.dart';

const Map<String, IconData> domains = {
  'Plumbing': Icons.plumbing,
  'Designer': Icons.design_services,
  'Carpenter': Icons.carpenter,
  'Landscaper': Icons.abc, //still need an icon
  'Painting': Icons.imagesearch_roller,
  'Cleaner': Icons.cleaning_services,
  'Tiler': Icons.abc, //still need an icon
  'Electrician': Icons.bolt
};

IconData? getIcon(String adType) {
  return domains[adType];
}
