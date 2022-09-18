import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

class ReviewWidget extends StatelessWidget {
  final Store<AppState> store;

  const ReviewWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //*****************STARS*****************//
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.star,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          //***************************************//

                          //*****************REPORT****************//
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.report_outlined,
                                  color: Theme.of(context).primaryColorDark,
                                )),
                          ),
                          //***************************************//
                        ],
                      ),
                      //******************MESSAGE*****************//
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Text(
                            "\"Wonderful service, I would definitely use this contractor again soon\"",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      //***************************************//
                    ],
                  ),
                ),
              )),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ReviewWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel();
}

// view model
class _ViewModel extends Vm {
  _ViewModel(); // implementinf hashcode
}
