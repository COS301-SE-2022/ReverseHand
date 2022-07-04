import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/quote.dart';
import 'package:redux_comp/app_state.dart';

class CardWidget extends StatelessWidget {
  final String titleText;
  final int price1;
  final int price2;
  final String details;
  final bool quote; // const CardWidget({Key? key
  // }) : super(key: key);
  final Store<AppState> store;
  const CardWidget(
      {Key? key,
      required this.titleText,
      required this.price1,
      required this.price2,
      required this.details,
      required this.quote,
      required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(titleText,
                    style: const TextStyle(fontSize: 30, color: Colors.white)),
                const Padding(padding: EdgeInsets.all(5)),
                const Text("Contact Details: ",
                    style: TextStyle(fontSize: 20, color: Colors.white70)),
                Text(details,
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
                const Padding(padding: EdgeInsets.all(5)),
                const Text("Quoted price: ",
                    style: TextStyle(fontSize: 20, color: Colors.white70)),
                Text("R$price1 - R$price2",
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
                Column(
                  children: [
                    if (quote) ...[const QuoteWidget()]
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
