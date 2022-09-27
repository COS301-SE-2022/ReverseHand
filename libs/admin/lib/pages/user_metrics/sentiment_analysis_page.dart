import 'package:admin/widgets/quickview_chat_widget.dart';
import 'package:admin/widgets/text_row_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/list_refresh_widget.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/sentiment_model.dart';

class SentimentAnalysisPage extends StatelessWidget {
  final Store<AppState> store;
  const SentimentAnalysisPage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            Widget appbar = AppBarWidget(
              title: "Sentiment Analysis",
              store: store,
              backButton: true,
            );
            return (vm.loading)
                ? Column(
                    children: [
                      //**********APPBAR***********//
                      appbar,
                      //*******************************************//
                      LoadingWidget(
                          topPadding: MediaQuery.of(context).size.height / 3,
                          bottomPadding: 0)
                    ],
                  )
                : Column(
                    children: [
                      //**********APPBAR***********//
                      appbar,

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Overall Sentiment",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      TextRowWidget(textValMap: {
                        "Overall Sentiment":
                            vm.gloabalSentiment.overallSentiment().toString(),
                        "Postive Messages":
                            vm.gloabalSentiment.positiveMessages.toString(),
                        "Neutral Messages":
                            vm.gloabalSentiment.neutralMessages.toString(),
                        "Negative Messages":
                            vm.gloabalSentiment.negativeMessages.toString(),
                      }),
                      Divider(
                        height: 20,
                        thickness: 0.5,
                        indent: 15,
                        endIndent: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Chats",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      ListRefreshWidget(widgets: [
                        QuickviewChatWidget(
                            store: store,
                            title: "Chat#001",
                            sentiments: const {
                              "Positive": 50,
                              "Neutral": 25,
                              "Negative": 25
                            }),
                        QuickviewChatWidget(
                            store: store,
                            title: "Chat#002",
                            sentiments: const {
                              "Positive": 20,
                              "Neutral": 55,
                              "Negative": 25
                            }),
                        QuickviewChatWidget(
                            store: store,
                            title: "Chat#003",
                            sentiments: const {
                              "Positive": 20,
                              "Neutral": 20,
                              "Negative": 60
                            }),
                      ], refreshFunction: () {})
                    ],
                  );
          },
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, SentimentAnalysisPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        gloabalSentiment: state.globalSentiment,
        dispatchGetUserReports: () {},
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final void Function() dispatchGetUserReports;
  final SentimentModel gloabalSentiment;

  _ViewModel({
    required this.loading,
    required this.gloabalSentiment,
    required this.dispatchGetUserReports,
  }) : super(equals: [loading, gloabalSentiment]); // implementinf hashcode;
}
