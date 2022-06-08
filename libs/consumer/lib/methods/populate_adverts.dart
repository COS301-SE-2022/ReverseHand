// import 'package:flutter/widgets.dart';
// import 'package:general/widgets/quick_view_job_card.dart';
// import 'package:redux_comp/models/advert_model.dart';

// List<Widget> populateAdverts(List<AdvertModel> adverts, BuildContext context) {
//   List<Widget> quickViewJobCardWidgets = [];
//   double height = (MediaQuery.of(context).size.height) / 3;

//   //*******************PADDING FOR THE TOP*******************//
//   quickViewJobCardWidgets.add(const Padding(padding: EdgeInsets.only(top: 20)));
//   //*********************************************************//

//   //*******QUICK VIEW AD WIDGETS - TAKES YOU TO DETAILED JOB VIEW ON CLICK********//
//   for (AdvertModel advert in adverts) {
//     quickViewJobCardWidgets.add(QuickViewJobCardWidget(
//       titleText: advert.title,
//       date: advert.dateCreated,
//       onTap: () {
//         // store.dispatch(ViewBidsAction(advert.id));
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (_) => ConsumerDetails(
//         //       store: store,
//         //       advert: advert,
//         //     ),
//         //   ),
//         // );
//       },
//     ));
//   }
//   //****************************************************************************//

//   return quickViewJobCardWidgets;
// }
