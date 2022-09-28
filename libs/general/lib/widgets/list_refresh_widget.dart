import 'package:flutter/material.dart';

class ListRefreshWidget extends StatelessWidget {
  final List<Widget> widgets;
  final void Function()
      refreshFunction; // The list of things you wish to refresh

  const ListRefreshWidget({
    Key? key,
    required this.widgets,
    required this.refreshFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => refreshFunction(),
      color: Colors.orange,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          child: Column(
            children: widgets,
          ),
        ),
      ),
    );
  }
}
