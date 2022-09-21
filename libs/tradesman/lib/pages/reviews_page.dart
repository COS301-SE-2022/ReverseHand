import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/actions/user/reviews/get_user_reviews_action.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/loading_widget.dart';

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
          builder: (BuildContext context, _ViewModel vm) =>
             Column(
              children: [
                //*******************APP BAR WIDGET*********************//
                AppBarWidget(store: store,title: "Reviews", backButton: true,),
                //********************************************************//
              
              ],
            ),
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
        dispatchGetUserReviewsAction: () => dispatch(GetUserReviewsAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final Function dispatchGetUserReviewsAction;

  _ViewModel({
    required this.loading,
    required this.dispatchGetUserReviewsAction,
  }) : super(equals: [loading]);
}
