import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

class JobCardWidget extends StatelessWidget {
  final String titleText;
  final String descText;
  final String date;
  const JobCardWidget(
      {Key? key,
      required this.titleText,
      required this.descText,
      required this.date})
      : super(key: key);

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 35),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //****************TITLE********************//
              Text(titleText,
                  style: const TextStyle(fontSize: 35, color: Colors.white)),
              //*****************************************//

              //****************DATE*******************//
              Row(
                children: [
                  // const Text(
                  //   "Posted: ",
                  //   style: TextStyle(fontSize: 20, color: Colors.white70),
                  // ),
                  //still deciding if this should be here
                  Text(
                    date,
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
              //****************************************//

              //****************LOCATION********************//
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  children: const [
                    // Icon(
                    //   Icons.location_on,
                    //   color: Colors.white,
                    //   size: 30.0,
                    // ), //icon spacing is giving issues at the moment
                    Text("Pretoria, Gauteng",
                        style: TextStyle(fontSize: 20, color: Colors.white))
                  ],
                ),
              ),
              //*****************************************//

              //****************DESCRIPTION*******************//
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                child: Text(descText,
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
              ),
              //**********************************************/

              //*****************EDIT ICON**********************//
              StoreConnector<AppState, _ViewModel>(
                vm: () => _Factory(this),
                builder: (BuildContext context, _ViewModel vm) => Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IconButton(
                    onPressed: vm.pushCreateNewAdvert,
                    icon: const Icon(Icons.edit),
                    color: Colors.white70,
                  ),
                ),
              ),
              //**********************************************/
            ],
          ),
        ],
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, JobCardWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      pushCreateNewAdvert: () => dispatch(
            NavigateAction.pushNamed('/consumer/create_advert'),
          ));
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushCreateNewAdvert;

  _ViewModel({
    required this.pushCreateNewAdvert,
  }); // implementinf hashcode
}
