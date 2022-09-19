import 'package:async_redux/async_redux.dart';
import 'package:consumer/pages/edit_advert_page.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
// import 'package:redux_comp/models/advert_model.dart';

//used in consumer and tradesman

class JobCardWidget extends StatelessWidget {
  final String titleText;
  final String descText;
  final String location;
  final String type;
  final String date;

  final Store<AppState> store;

  const JobCardWidget(
      {Key? key,
      required this.titleText,
      required this.descText,
      required this.location,
      required this.type,
      required this.date,
      required this.store})
      : super(key: key);

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //****************DATE*******************//
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
              child: Text(
                date,
                style: const TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 186, 186, 186)),
              ),
            ),
            //****************************************//

            Row(
              children: [
                //****************TITLE********************//
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: SizedBox(
                    child: Text(
                      titleText,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                //*****************************************//

                //******************EDIT ICON****************//
                StoreConnector<AppState, _ViewModel>(
                  vm: () => _Factory(this),
                  builder: (BuildContext context, _ViewModel vm) =>
                    (vm.advert.acceptedBid == null)
                      ? Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: vm.pushEditAdvert,
                            icon: const Icon(Icons.edit),
                            color: Colors.white70,
                          ),
                        )
                      : Container()),
                //**********************************************/
              ],
            ),

            //****************LOCATION********************//
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.only(right: 1)),

                  Text(location,
                      style: const TextStyle(fontSize: 17, color: Colors.grey)),
                  //*****************************************//

                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.grey,
                      )),
                  //*****************************************//

                  //****************TRADE********************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(right: 1)),
                        Text(type,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.grey)),
                      ],
                    ),
                  ),
                  // *****************************************//
                ],
              ),
            ),

            const Divider(
              height: 20,
              thickness: 1,
              indent: 5,
              endIndent: 15,
              color: Colors.orange,
            ),

            //****************DESCRIPTION*******************//
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
                child: Text(descText,
                    // textWidthBasis: TextWidthBasis.longestLine,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      // height: 1.3,
                      // letterSpacing: 1
                    )),
              ),
            ),
            //**********************************************/
          ],
        ),
      ),
    );
  }
}


// factory for view model
class _Factory extends VmFactory<AppState, JobCardWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushEditAdvert: () => dispatch(
          NavigateAction.pushNamed('/consumer/edit_advert_page'),
        ),
        advert: state.activeAd!,
      );
}

// view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final VoidCallback pushEditAdvert;

  _ViewModel({
    required this.advert,
    required this.pushEditAdvert,
  }) : super(equals: [advert]); // implementinf hashcode
}
