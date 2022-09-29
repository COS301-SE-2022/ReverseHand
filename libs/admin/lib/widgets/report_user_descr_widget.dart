import 'package:flutter/material.dart';

class ReportUserDescrWidget extends StatelessWidget {
  final String title;
  final String name;
  final void Function() function;
  const ReportUserDescrWidget(
      {Key? key,
      required this.title,
      required this.name,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 30, top: 20, bottom: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
                softWrap: false,
              ),
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.white70,
                size: 25.0,
              ),
              const Padding(padding: EdgeInsets.only(right: 5)),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: function,
                child: const Text(
                  "View User",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                  softWrap: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
