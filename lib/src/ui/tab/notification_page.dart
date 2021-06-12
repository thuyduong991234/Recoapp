import 'package:flutter/material.dart';
import 'package:recoapp/src/ui/constants.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Thông báo",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: Text("Mới nhất",
                      style: TextStyle(
                          color: kTextThirdColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Đánh dấu tất cả đã đọc",
                      style: TextStyle(
                          color: kThirdColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal)),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.white,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: index == 3
                              ? Colors.white
                              : kPrimaryColor.withOpacity(0.1),
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xffededed),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              "https://media-cdn.tripadvisor.com/media/photo-s/11/97/d8/1d/restaurant-logo.jpg",
                              width: 40,
                              height: 40,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lẩu & Nướng Yu: CHỈ 155K COMBO THẢ GA",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    style: TextStyle(
                                        height: 1.5,
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Combo lẩu chỉ còn 155k\nĐặt chỗ ngay",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                    style: TextStyle(
                                        height: 1.5,
                                        color: Colors.black,
                                        fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Từ 01/05/2021 - 01/06/2021",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              height: 1.5,
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                }),
          ))
        ])));
  }
}
