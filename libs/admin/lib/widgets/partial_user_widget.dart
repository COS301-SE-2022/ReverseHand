import 'package:flutter/material.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:redux_comp/models/admin/app_management/models/cognito_user_model.dart';

class PartialUserWidget extends StatelessWidget {
  final CognitoUserModel user;
  const PartialUserWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: HintWidget(
            colour: Colors.white,
            text: "This user has not completed their profile",
            padding: 25,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        SizedBox(
          height: 90,
          width: MediaQuery.of(context).size.width / 1.15,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Column(
                children: [
                  //*******************EMAIL********************//
                  Row(children: [
                    Icon(
                      Icons.email_outlined,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    const Padding(padding: EdgeInsets.only(right: 5)),
                    const Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ]),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.25,
                        child: Text(
                          user.email,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),

                  //********************************************//
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
          child: SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width / 1.15,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.filter_list,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            user.id[0] == "c" ? "Client" : "Contractor",
                            style: const TextStyle(fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            (user.enabled) ? Icons.check : Icons.close,
                            color: (user.enabled) ? Colors.green : Colors.red,
                          ),
                          Text(
                            (user.enabled) ? "Enabled" : "Disabled",
                            style: const TextStyle(fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
