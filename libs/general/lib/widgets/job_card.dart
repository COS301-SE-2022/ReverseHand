import 'package:async_redux/async_redux.dart';
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
  final bool? editButton;

  const JobCardWidget({
    Key? key,
    required this.titleText,
    required this.descText,
    required this.location,
    required this.type,
    required this.date,
    this.editButton,
  }) : super(key: key);

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //****************DATE*******************//
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 1, top: 10),
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 186, 186, 186),
                  ),
                ),
              ),
              // //******************EDIT ICON****************//
              editButton == true
                  ? StoreConnector<AppState, _ViewModel>(
                      vm: () => _Factory(this),
                      builder: (BuildContext context, _ViewModel vm) =>
                          vm.advert.acceptedBid == null && vm.bidCount == 0
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                      onPressed: vm.pushEditAdvert,
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 20,
                                      ),
                                      color: Colors.white70,
                                    ),
                                  ),
                                )
                              : Container())
                  : Container()
              //**********************************************/
            ],
          ),
          //****************************************//

          Row(
            children: [
              //****************TITLE********************//
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.25,
                  child: Text(
                    titleText,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //*****************************************//
            ],
          ),

          //****************LOCATION********************//
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 5),
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
                  ),
                ),
                //*****************************************//

                //****************TRADE********************//
                Padding(
                  padding: const EdgeInsets.only(left: 10),
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
            thickness: 1.1,
            indent: 0,
            endIndent: 15,
            color: Colors.orange,
          ),

          //****************DESCRIPTION*******************//
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, right: 5),
              child: Text(
                descText,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          //**********************************************/
        ],
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
        bidCount: state.bids.length + state.shortlistBids.length,
      );
}

// view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final VoidCallback pushEditAdvert;
  final int bidCount;

  _ViewModel({
    required this.advert,
    required this.bidCount,
    required this.pushEditAdvert,
  }) : super(equals: [advert]); // implementinf hashcode
}
