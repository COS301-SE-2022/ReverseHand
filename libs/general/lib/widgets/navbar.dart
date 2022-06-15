import 'package:flutter/material.dart';

//should be converted to stateless

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black, spreadRadius: 0, blurRadius: 6),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: BottomAppBar(
            color: Theme.of(context).primaryColorDark,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  splashRadius: 30,
                  highlightColor: Colors.orange,
                  splashColor: Colors.white,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  splashRadius: 30,
                  highlightColor: Colors.orange,
                  splashColor: Colors.white,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.print,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  splashRadius: 30,
                  highlightColor: Colors.orange,
                  splashColor: Colors.white,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  splashRadius: 30,
                  highlightColor: Colors.orange,
                  splashColor: Colors.white,
                ),
              ],
            )),
      ),
    );
  }
}
