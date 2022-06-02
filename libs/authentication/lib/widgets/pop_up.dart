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
    return Container(
      height: 350,
      decoration: const BoxDecoration(
        color: Colors.black87,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            const Text(
                "Enter verification code sent to your email/phone",
                style: TextStyle(fontSize: 20),
              ),
            const TransparentDividerWidget(),
              //*****************OTP**********************
            TextFieldWidget(
                label: 'otp',
                obscure: false,
                controller: otpController,
              ),
              const ButtonWidget(),
          ],
        ),
      ),
    );
  }
}
