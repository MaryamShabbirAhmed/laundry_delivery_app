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
      padding: EdgeInsets.only(left: 15.0, bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 25),
                children: <TextSpan>[
                  TextSpan(
                      text: title,
                      style: TextStyle(fontWeight: FontWeight.w500)),
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

class ListviewTile extends StatelessWidget {
  String status;
  Color backgroundColor;

  ListviewTile({Key? key, required this.status, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Color(0xffDDDDDD),
                blurRadius: 3,
                spreadRadius: 1.1,
                offset: Offset(0.0, 0.0),
              )
            ]),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: StatusWidget(
                  status: status, backgroundColor: backgroundColor),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                ListViewInfoWidget(title: 'Order No', info: '10'),
                ListViewInfoWidget(title: 'Name: ', info: 'Vikas Kumar Ray'),
                ListViewInfoWidget(title: 'Contact No: ', info: '987654321'),
                ListViewInfoWidget(
                    title: 'Address No: ',
                    info:
                        'OvalEdge India Private Limited Manjeera Trinity Corporate, #321KPBH, Phase 3, Hyderabad -500072'),
                ListViewInfoWidget(title: 'No of cloths: ', info: '05'),
                ListViewInfoWidget(title: 'Payment: ', info: '500 rs'),
                ListViewInfoWidget(title: 'Payment type: ', info: 'cash'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Map<String,String> listData={};

List<Map> listHistoryTile = [
  {
    "orderNo": '10',
    "orderStatus": 'Pending',
    "name": 'Vikas Kumar Ray',
    "ContactNo": '564656466',
    "addressNo": '53535453455',
    "noOfCloths": '10',
    "payment": '10',
    "time":'20 days ago',
  },
  {
    "orderNo": '10',
    "orderStatus": 'Due',
    "name": 'Rahul Kumar',
    "ContactNo": '533535453',
    "addressNo": '10',
    "noOfCloths": '10',
    "payment": '10',
    "time":'20 days ago',
  },
  {
    "orderNo": '14',
    "orderStatus": 'process',
    "name": 'Sindu Jat',
    "ContactNo": '74837930',
    "addressNo": '10',
    "noCfCloths": '10',
    "payment": '10',
    "time":'20 days ago',
  },
  {
    "orderNo": '10',
    "orderStatus": 'paid',
    "name": 'Vikram ',
    "ContactNo": '14535350',
    "addressNo": '134543530',
    "noOfCloths": '10',
    "payment": '10',
    "time":'20 days ago',
  },
  {
    "orderNo": '10',
    "orderStatus": 'Due',
    "name": 'Rahul Kumar',
    "ContactNo": '533535453',
    "addressNo": '10',
    "noOfCloths": '10',
    "payment": '10',
    "time":'20 days ago',
  },
  {
    "orderNo": '14',
    "orderStatus": 'process',
    "name": 'Sindu Jat',
    "ContactNo": '74837930',
    "addressNo": '10',
    "noCfCloths": '10',
    "payment": '10',
    "time":'20 days ago',
  },
  {
    "orderNo": '10',
    "orderStatus": 'paid',
    "name": 'Vikram ',
    "ContactNo": '14535350',
    "addressNo": '134543530',
    "noOfCloths": '10',
    "payment": '10',
    "time":'20 days ago',
  },
];
