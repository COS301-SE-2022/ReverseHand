import 'package:flutter/material.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  int index = 0;
  final pages = [
    //add pages here
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: NavigationBar(
            height: 60,
            selectedIndex: index,
            backgroundColor: Theme.of(context).primaryColorDark,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: const [
              //AT LEAST 2 NAVIGATION DESTINATIONS MUST BE PRESENT
              NavigationDestination(
                icon: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                selectedIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                label: "first",
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                selectedIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                label: "first",
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                selectedIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                label: "first",
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                selectedIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                label: "first",
              ),
            ]),
      ),
    );
  }
}
