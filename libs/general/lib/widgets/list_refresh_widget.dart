import 'package:flutter/material.dart';

class ListRefreshWidget extends StatelessWidget {
  final List<Widget> widgets; // The list of things you wish to refresh
  final void Function()
      refreshFunction; 

  const ListRefreshWidget({
    Key? key,
    required this.widgets,
    required this.refreshFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async => refreshFunction(),
        color: Colors.orange,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(top: 0), //ListView has default padding I don't want
            children: widgets,
          ),
        ),
      ),
    );
  }
}
