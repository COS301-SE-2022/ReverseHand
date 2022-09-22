import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/models/review_model.dart';
import 'package:redux_comp/redux_comp.dart';
import '../widgets/reviews/review_widget.dart';


class ReviewsPage extends StatelessWidget {
  final Store<AppState> store;

  const ReviewsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            List<ReviewWidget> reviews = vm
              .reviews
              .map((r) => ReviewWidget(review: r, store: store))
              .toList();

             return Column(
              children: [
                //*******************APP BAR WIDGET*********************//
                AppBarWidget(store: store,title: "Reviews", backButton: true,),
                //********************************************************//

                const Padding(padding: EdgeInsets.only(top: 15),),
                ...reviews
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, ReviewsPage> {
  _Factory(widget) : super(widget);
  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        reviews: state.userDetails.reviews,
        
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final List<ReviewModel> reviews;

  _ViewModel({
    required this.loading,
    required this.reviews,
  }) : super(equals: [loading, reviews]);
}
