import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

class ShortlistAcceptButtonWidget extends StatefulWidget {
  final VoidCallback onTap;
  final Store<AppState> store;
  const ShortlistAcceptButtonWidget(
      {Key? key, required this.onTap, required this.store})
      : super(key: key);

  @override
  State<ShortlistAcceptButtonWidget> createState() => _State();
}

class _State extends State<ShortlistAcceptButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(255, 153, 0, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.store.state.user!.activeBid!.isShortlisted()
              ? "ACCEPT"
              : "SHORTLIST",
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
