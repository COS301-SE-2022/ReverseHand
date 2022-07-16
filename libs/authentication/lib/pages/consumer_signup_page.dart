//implement later
// import 'package:async_redux/async_redux.dart';
// import 'package:flutter/material.dart';
// import 'package:general/widgets/dialog_helper.dart';
// import 'package:general/widgets/divider.dart';
// import 'package:redux_comp/actions/user/register_user_action.dart';
// import 'package:redux_comp/redux_comp.dart';
// import '../widgets/button.dart';
// import '../widgets/circle_blur_widget.dart';
// import '../widgets/divider.dart';
// import '../widgets/link.dart';
// import '../widgets/otp_pop_up.dart';
// import '../widgets/textfield.dart';
// import 'location_page.dart';

// class ConsumerSignUpWidget extends StatefulWidget {
//   final Store<AppState> store;

//    const ConsumerSignUpWidget({
//     Key? key,
//     required this.store
//   }): super(key: key);

//   @override
//   State<ConsumerSignUpWidget> createState() => _ConsumerSignUpState();
// }

// class _ConsumerSignUpState extends State<ConsumerSignUpWidget> {

//     // controllers for retrieveing text
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final cellController = TextEditingController();
//   final tradeController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmController = TextEditingController();

//     // used for validation
//   final _consumerFormKey = GlobalKey<FormState>();

//   String? Function(String?) _createValidator(
//       String kind, String invalidMsg, RegExp regex) {
//     return (value) {
//       if (value == null || value.isEmpty) {
//         return 'A $kind must be entered';
//       }

//       if (!regex.hasMatch(value)) {
//         return "${kind[0].toUpperCase() + kind.substring(1)} $invalidMsg";
//       }

//       return null;
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: const <Widget>[
//         //*****************Top circle blur**********************
//         CircleBlurWidget(),
//         //*******************************************************

//         //*****************Bottom circle blur**********************
//         Align(
//           alignment: Alignment.bottomRight,
//           child: CircleBlurWidget(),
//         ),
//         //******************************************************* */
//       ],
//     );
//   }
// }
// }

// // factory for view model
// class _Factory extends VmFactory<AppState, ConsumerSignUpWidget> {
//   _Factory(widget) : super(widget);

//   @override
//   _ViewModel fromStore() => _ViewModel(
//         dispatchSignUpAction:
//             (email, name, cell, tradeTypes, password, isConsumer) => dispatch(
//                 RegisterUserAction(
//                     email, name, cell, tradeTypes, password, isConsumer)),
//         pushLoginPage: () => dispatch(NavigateAction.pushNamed('/login')),
//       );
// }

// // view model
// class _ViewModel extends Vm {
//   final VoidCallback pushLoginPage;
//   final void Function(String, String, String, List<String>, String, bool)
//       dispatchSignUpAction;

//   _ViewModel({
//     required this.dispatchSignUpAction,
//     required this.pushLoginPage,
//   }); // implementing hashcode
// }
