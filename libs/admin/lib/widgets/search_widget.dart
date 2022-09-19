import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                searchController.clear();
              },
            ),
            hintText: 'Search...',
            hintStyle: const TextStyle(color: Colors.black),
            border: InputBorder.none,
            fillColor: Colors.white),
        controller: searchController,
        onChanged: (text) {
          //when the input text has changed
        },
      ),
    );
  }
}
