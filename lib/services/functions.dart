import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class Functions {
  static String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' Gün Önce';
      } else {
        time = diff.inDays.toString() + ' Gün Önce';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' Hafta Önce';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' Hafta Önce';
      }
    }

    return time;
  }

  static String dateTimeFormat(DateTime dateTime) {
    String formattedDate = DateFormat('dd.MM.yyyy - kk:mm').format(dateTime);
    return formattedDate;
  }

  static String convertToAgo(DateTime input) {
    var now = DateTime.now();
    var date = input;
    var diff = now.difference(date);
    var time = '';



    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      timeago.setLocaleMessages('tr', timeago.TrMessages());
      time=timeago.format(now.subtract(diff),locale: 'tr');
      //time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' Gün Önce';
      } else {
        time = diff.inDays.toString() + ' Gün Önce';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' Hafta Önce';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' Hafta Önce';
      }
    }

    return time;
  }

  static loadingView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white38,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, int index) {
            Widget cesit;
            return Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(children: [
                          Container(
                            width: 45,
                            height: 45,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      '',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ]),
                          )
                        ]),
                      ),
                      AnimatedContainer(
                        height: 35,
                        width: 35,
                        padding: EdgeInsets.all(5),
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Text(''),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.shade200),
                              child: cesit,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            /* Container(
                              padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Level',
                              ),
                            ),*/
                          ],
                        ),
                        Text(''),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  static   questionLoadingView() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.black45,
      child: Column(
        children: [
          Card(
            color: Colors.grey.shade300,
            child: ListTile(
              title: Text(
                '',
                style: TextStyle(color: Colors.black),
              ),
              leading: Text(
                '',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Card(
                      child: ListTile(
                        tileColor: Colors.grey.shade300,
                        leading: Text(''),
                        title: Text(''),
                      ),
                    ),
                  );
                }),
          ),
          Center(
            child: Text(
              '',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Card(
            color: Colors.blue.withOpacity(.1),
            child: Container(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.done,
                          size: 40,
                          color: Colors.green,
                        ),
                        Text(
                          '',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.clear,
                          size: 40,
                          color: Colors.red,
                        ),
                        Text(
                          '',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60.0),
                  child: Wrap(
                    children: [
                      Icon(
                        Icons.leaderboard_outlined,
                        size: 25,
                        color: Colors.indigo,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
