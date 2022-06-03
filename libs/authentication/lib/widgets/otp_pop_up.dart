import 'package:authentication/widgets/divider.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

class PopupWidget extends StatelessWidget {
  
  PopupWidget({
    Key? key,
  }): super(key: key);

  final otpController = TextEditingController();

  void dispose() {
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 350,
        decoration: const BoxDecoration(
          color: Colors.black87,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.topCenter,
              child: const Text(
                  "Enter verification code sent to your email/phone",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const TransparentDividerWidget(),

              //*****************OTP text field**********************
              TextFieldWidget(
                  label: 'otp',
                  obscure: false,
                  controller: otpController,
                ),
                const TransparentDividerWidget(),
                //*****************************************************

                //***************Verify Button *********************** */
                const ButtonWidget(),
                //*****************************************************

            ],
          ),
        ),
      ),
    );
  }
}
