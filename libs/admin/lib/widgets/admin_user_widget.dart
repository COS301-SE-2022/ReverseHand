import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/admin_user_model.dart';

class AdminUserWidget extends StatelessWidget {
  final AdminUserModel user;
  const AdminUserWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
          child: SizedBox(
            height: 130,
            width: MediaQuery.of(context).size.width / 1.15,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            user.email,
                            style: const TextStyle(fontSize: 18),
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
                            Icons.person_outline,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            user.name,
                            style: const TextStyle(fontSize: 18),
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
                            Icons.front_hand_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            user.warnings.toString(),
                            style: const TextStyle(fontSize: 18),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
          child: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width / 1.15,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                            user.id[0] == "c" ? "Customer" : "Tradesman",
                            style: const TextStyle(fontSize: 18),
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
                            style: const TextStyle(fontSize: 18),
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
