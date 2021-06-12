import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:recoapp/src/ui/constants.dart';

class RecommendForYouList extends StatefulWidget {
  RecommendForYouList();

  @override
  _RecommendForYouListState createState() => _RecommendForYouListState();
}

class _RecommendForYouListState extends State<RecommendForYouList> {
  Widget _buildFirstItem() {}

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Text("Gợi ý cho bạn",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
      const Divider(
        height: 5,
        thickness: 3,
        indent: 20,
        endIndent: 300,
        color: kPrimaryColor,
      ),
      SizedBox(
        height: 20.0,
      ),
      Column(
        children: <Widget>[
          //First Item
          Container(
            margin: EdgeInsets.only(right: 20.0, left: 20.0),
            child: GestureDetector(
                onTap: () => {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Image
                    Container(
                      height: 180.0,
                      child: ImageSlideshow(
                        initialPage: 0,
                        indicatorColor: kPrimaryColor,
                        indicatorBackgroundColor: Color(0xFF9A9693),
                        children: [
                          Image.network(
                            'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg',
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg',
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg',
                            fit: BoxFit.cover,
                          ),
                        ],
                        autoPlayInterval: 3000,
                      ),
                    ),
                    //Restaurant name
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text("Lẩu & Nướng Yu Mei",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0))),
                    //Vouchet and distance
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Ưu đãi: -50%",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                            Text("7km",
                                style: TextStyle(
                                    color: Color(0xFFFF8A00),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                    //Rating
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.star,
                                color: Color(0xFFFF8A00), size: 20.0),
                            Icon(Icons.star,
                                color: Color(0xFFFF8A00), size: 20.0),
                            Icon(Icons.star,
                                color: Color(0xFFFF8A00), size: 20.0),
                            Icon(Icons.star,
                                color: Color(0xFFFF8A00), size: 20.0),
                            Icon(Icons.star,
                                color: Color(0xFFFF8A00), size: 20.0),
                            SizedBox(width: 5),
                            Text("100 - 10 lượt đặt",
                                style: TextStyle(
                                    color: Color(0xFF9A9693), fontSize: 14.0)),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("Đinh Bộ Lĩnh, P.26, Q.Bình Thạnh, Tp HCM",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xFF9A9693), fontSize: 14.0)),
                    ),
                    //tag
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Chip(
                              backgroundColor: Color(0xFFFF9D7F),
                              labelStyle: TextStyle(
                                  color: kTextMainColor, fontSize: 14.0),
                              label: Text('Lẩu'),
                            ),
                            SizedBox(width: 10.0),
                            Chip(
                              backgroundColor: Color(0xFFFECE52),
                              labelStyle: TextStyle(
                                  color: kTextMainColor, fontSize: 14.0),
                              label: Text('Đồ nướng'),
                            ),
                          ],
                        )),
                  ],
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 4,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (0.7),
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: index % 2 == 0
                      ? EdgeInsets.only(right: 10.0, left: 20.0)
                      : EdgeInsets.only(right: 20.0, left: 10.0),
                  child: GestureDetector(
                      onTap: () => {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Image
                          Container(
                              height: 110.0,
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg'))))),
                          //Restaurant name
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Lẩu & Nướng Yu Mei",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0))),
                          //Vouchet and distance
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Ưu đãi: -50%",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("7km",
                                      style: TextStyle(
                                          color: Color(0xFFFF8A00),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                          //Rating
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.star,
                                      color: Color(0xFFFF8A00), size: 10.0),
                                  Icon(Icons.star,
                                      color: Color(0xFFFF8A00), size: 10.0),
                                  Icon(Icons.star,
                                      color: Color(0xFFFF8A00), size: 10.0),
                                  Icon(Icons.star,
                                      color: Color(0xFFFF8A00), size: 10.0),
                                  Icon(Icons.star,
                                      color: Color(0xFFFF8A00), size: 10.0),
                                  SizedBox(width: 5),
                                  Text("100 - 10 lượt đặt",
                                      style: TextStyle(
                                          color: Color(0xFF9A9693),
                                          fontSize: 12.0)),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Đinh Bộ Lĩnh, P.26, Q.Bình Thạnh, Tp HCM",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFF9A9693), fontSize: 12.0)),
                          ),
                          //tag
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Chip(
                                    backgroundColor: Color(0xFFFF9D7F),
                                    labelStyle: TextStyle(
                                        color: kTextMainColor, fontSize: 12.0),
                                    label: Text('Lẩu'),
                                  ),
                                  SizedBox(width: 10.0),
                                  Chip(
                                    backgroundColor: Color(0xFFFECE52),
                                    labelStyle: TextStyle(
                                        color: kTextMainColor, fontSize: 12.0),
                                    label: Text('Đồ nướng'),
                                  ),
                                ],
                              )),
                        ],
                      )),
                );
              }),
          SizedBox(height: 10.0),
          Center(
            child: Text(
              "Xem thêm",
              style: TextStyle(color: Color(0xFF9A9693)),
            ),
          )
        ],
        //More
      )
    ]);
  }
}
