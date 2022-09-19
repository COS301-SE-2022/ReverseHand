import 'package:flutter/material.dart';

class ReportUserSelectWidget extends StatefulWidget {
  const ReportUserSelectWidget({Key? key}) : super(key: key);

  final List<String> items = const [
   'Disrespectful or offensive',
    'Threatening violence or physical harm',
    'Prejudice or discrimination',
    'Harrassment',
    'Not who they say they are',
  ];
  @override
  State<ReportUserSelectWidget> createState() => _RadioSelectWidgetState();
}

class _RadioSelectWidgetState extends State<ReportUserSelectWidget> {
  String? _type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListBody(
        children: widget.items
            .map((tradeType) => ListTile(
                  title: Text(
                    tradeType,
                    style: const TextStyle(fontSize: 17.5),
                  ),
                  leading: Radio<String>(
                    value: tradeType,
                    groupValue: _type,
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.orange),
                    onChanged: (String? value) {
                      setState(() {
                        _type = value;
                      });
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }
}
