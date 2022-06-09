import 'package:flutter/material.dart';
import 'package:redux_comp/models/bid_model.dart';

// function to create list of bids
List<Widget> populateBids(List<BidModel> bids) {
  List<Widget> quickViewBidWidgets = [];

  //**********QUICK VIEW BID WIDGETS - TAKES YOU TO DETAILED BID VIEW ON CLICK***********//
  for (BidModel bid in bids) {
    quickViewBidWidgets.add(QuickViewBidWidget(
      bid: bid,
    ));
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
                bid.id,
                style: const TextStyle(fontSize: 25, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}

