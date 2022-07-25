import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';

// used to create a list of adverts
List<Widget> populateAdverts(List<AdvertModel> adverts, Store<AppState> store) {
  List<Widget> quickViewJobCardWidgets = [];

  for (AdvertModel advert in adverts) {
    quickViewJobCardWidgets.add(
      QuickViewJobCardWidget(
        advert: advert,
        store: store,
      ),
    );
  }

  return quickViewJobCardWidgets;
}
