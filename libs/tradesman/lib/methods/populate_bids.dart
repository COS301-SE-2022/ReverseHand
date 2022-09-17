import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:tradesman/widgets/quick_view_bid_widget.dart';

// function to create list of bids
List<Widget> populateBids(
    String userId, List<BidModel> bids, Store<AppState> store) {
  List<Widget> quickViewBidWidgets = [];

  for (BidModel bid in bids) {
    // checking when to append to front
    if (bid.userId == userId) {
      quickViewBidWidgets.insert(
        0,
        TQuickViewBidWidget(
          bid: bid,
          store: store,
        ),
      );
    } else {
      quickViewBidWidgets.add(
        QuickViewBidWidget(
          bid: bid,
        ),
      );
    }
  }

  return quickViewBidWidgets;
}

class QuickViewBidWidget extends StatelessWidget {
  final BidModel bid;

  const QuickViewBidWidget({
    Key? key,
    required this.bid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromRGBO(255, 153, 0, 1), width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Text(
          '${bid.name} : ${bid.price}',
          style: const TextStyle(fontSize: 25, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
