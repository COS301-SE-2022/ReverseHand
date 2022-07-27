import 'package:flutter/material.dart';

class ActionBarWidget extends StatefulWidget {
  const ActionBarWidget({Key? key}) : super(key: key);

  @override
  _ActionBarWidgetState createState() => _ActionBarWidgetState();
}

class _ActionBarWidgetState extends State<ActionBarWidget> {
  // final StreamMessageInputController controller =
  //     StreamMessageInputController();

  // Timer? _debounce;

  // Future<void> _sendMessage() async {
  //   if (controller.text.isNotEmpty) {
  //     StreamChannel.of(context).channel.sendMessage(controller.message);
  //     controller.clear();
  //     FocusScope.of(context).unfocus();
  //   }
  // }

  // void _onTextChange() {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(seconds: 1), () {
  //     if (mounted) {
  //       StreamChannel.of(context).channel.keyStroke();
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   controller.addListener(_onTextChange);
  // }

  // @override
  // void dispose() {
  //   controller.removeListener(_onTextChange);
  //   controller.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: TextField(
                // controller: controller.textEditingController,
                // onChanged: (val) {
                //   controller.text = val;
                // },
                style: TextStyle(fontSize: 14, color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                // onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 12,
              right: 24.0,
            ),
            // child: GlowingActionButton(
            //   color: AppColors.accent,
            //   icon: Icons.send_rounded,
            //   onPressed: _sendMessage,
            // ),
          ),
        ],
      ),
    );
  }
}