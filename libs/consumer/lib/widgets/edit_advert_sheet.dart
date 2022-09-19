import 'package:authentication/widgets/auth_textfield_light.dart';
import 'package:general/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:general/widgets/textfield.dart';

class EditAdvertSheet extends StatelessWidget {
  
  final titleController = TextEditingController();
  final descrController = TextEditingController();
  final tradeController = TextEditingController();

  EditAdvertSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: 470,
        child: Container(
          color: Colors.white70,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //*****************DELETE***************//
                      IconButton(
                          onPressed: () {
                            //are you sure you want to delete this bid
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.black,
                          )),
                      //**************************************//

                      //*****************CLOSE****************//
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context, null);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          )),
                      //**************************************//
                    ],
                  ),

                  //*****************HEADING****************//
                  const Text(
                    "Edit Bid",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  //**************************************//

                  //*****************TITLE****************//
                  const Padding(
                    padding: EdgeInsets.only(left: 40, bottom: 5),
                    child: HintWidget(
                      text: "Edit title", colour: Colors.black, padding: 15),
                  ),

                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextFormField(
                      cursorHeight: 20,
                      cursorColor: Theme.of(context).scaffoldBackgroundColor,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      controller: titleController,
                      onTap: () {},
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  //**************************************//

                  //*****************TRADE TYPE***********//
                  
                  //**************************************//

                  //*****************DESCRIPTION**********//
                  const Padding(
                    padding: EdgeInsets.only(left: 40, bottom: 5),
                    child: HintWidget(
                      text: "Edit description", colour: Colors.black, padding: 15),
                  ),

                  SizedBox(
                    height: 80,
                    width: 300,
                    child: TextFormField(
                      cursorHeight: 20,
                      maxLines: 3,
                      cursorColor: Theme.of(context).scaffoldBackgroundColor,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      controller: descrController,
                      onTap: () {},
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //**************************************//

                  //*****************LOCATION*************//
                  
                  //**************************************//

                  //*****************PHOTOS***************//
                  
                  //**************************************//

                  //*****************BUTTONS**************//
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  ButtonWidget(text: "Save", function: () {})
                  //**************************************//
                ],
              ),
            ),
        ),
      ),
    );
  }
}
