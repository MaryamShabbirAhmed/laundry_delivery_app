import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/statusWidget.dart';

class ListViewInfoWidget extends StatelessWidget {
  String? title;

  String? info;

  ListViewInfoWidget({Key? key, this.title, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 25),
                children: <TextSpan>[
                  TextSpan(
                      text: title,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: info,
                      style: TextStyle(color: darkGreyColor, fontSize: 25)),
                ],
              ),
              textScaleFactor: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

