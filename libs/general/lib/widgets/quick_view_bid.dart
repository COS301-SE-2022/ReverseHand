import 'package:flutter/material.dart';
import 'package:redux_comp/models/bid_model.dart';

class QuickViewBidWidget extends StatelessWidget {
  // final String name;
  // final void Function() onTap;

  final BidModel bid;

  const QuickViewBidWidget({
    Key? key,
    required this.bid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
          onTap: () {
          widget.store.dispatch(SetActiveBidAction(bid.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ViewBid(
                store: widget.store,
              ),
            ),
          );
        },,
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
          )),
    );
  }
}
