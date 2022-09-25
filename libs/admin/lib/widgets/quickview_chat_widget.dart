import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/report_model.dart';
import 'package:redux_comp/redux_comp.dart';

class QuickviewChatWidget extends StatelessWidget {
  final Store<AppState> store;
  final String title;
  final Map<String, double> sentiments;

  const QuickviewChatWidget({
    Key? key,
    required this.store,
    required this.title,
    required this.sentiments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? maxKey;
    double maxValue = double.negativeInfinity;
    sentiments.forEach((key, value) {
      if (value > maxValue) {
        maxValue = value;
        maxKey = key;
      }
    });

    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) {
          return InkWell(
            onTap: () {},
            child: Card(
              margin: const EdgeInsets.all(12),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.help_outline,
                              color: Colors.black,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 5)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Text(
                                title,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              (maxKey == "Positive")
                                  ? Icons.sentiment_very_satisfied
                                  : (maxKey == "Neutral")
                                      ? Icons.sentiment_neutral
                                      : (maxKey == "Negative")
                                          ? Icons.sentiment_very_dissatisfied
                                          : Icons.help_outline,
                              color: Colors.black,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 5)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Text(
                                "$maxKey",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.circle,
                        color: (maxKey == "Positive")
                            ? Colors.green
                            : (maxKey == "Neutral")
                                ? Colors.orange
                                : (maxKey == "Negative")
                                    ? Colors.red
                                    : Colors.black)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, QuickviewChatWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel();
}

// view model
class _ViewModel extends Vm {
  _ViewModel();
}

// Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
//                 child: Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.help_outline,
//                               color: Theme.of(context).primaryColor,
//                             ),
//                             const Padding(padding: EdgeInsets.only(right: 5)),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width / 1.4,
//                               child: Text(
//                                 title
//                                 style: const TextStyle(
//                                     fontSize: 18, color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Padding(padding: EdgeInsets.only(top: 10)),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.text_snippet_outlined,
//                               color: Theme.of(context).primaryColor,
//                             ),
//                             const Padding(padding: EdgeInsets.only(right: 5)),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width / 1.4,
//                               child: Text(
//                                 sentiments
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 18, color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),