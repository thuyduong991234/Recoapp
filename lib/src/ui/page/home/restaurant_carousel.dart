import 'package:flutter/material.dart';
import 'package:recoapp/src/ui/constants.dart';

class RestaurantCarousel extends StatefulWidget {
  final String title;

  RestaurantCarousel(this.title);

  @override
  _RestaurantCarouselState createState() => _RestaurantCarouselState();
}

class _RestaurantCarouselState extends State<RestaurantCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Text(widget.title,
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
        Container(
          height: 350.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(left: 20.0),
                 width: 300,
                child: GestureDetector(
                    onTap: () => {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Image
                        Container(
                          height: 180.0,
                          margin: index == 4? EdgeInsets.only(right: 20.0) :EdgeInsets.only(right: 0.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg')))),
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
                            padding: index == 4 ? EdgeInsets.only(top: 10, right: 20) : EdgeInsets.only(top: 10),
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
                                        color: Color(0xFF9A9693),
                                        fontSize: 14.0)),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                              "Đinh Bộ Lĩnh, P.26, Q.Bình Thạnh, Tp HCM",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color(0xFF9A9693), fontSize: 14.0)),
                        ),
                        //tag
                        Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Chip(
                                  backgroundColor: kSecondaryColor,
                                  labelStyle: TextStyle(
                                      color: kTextMainColor, fontSize: 14.0),
                                  label: Text('Lẩu'),
                                ),
                                SizedBox(width: 10.0),
                                Chip(
                                  backgroundColor: tagChip,
                                  labelStyle: TextStyle(
                                      color: kTextMainColor, fontSize: 14.0),
                                  label: Text('Đồ nướng'),
                                ),
                              ],
                            )),
                      ],
                    )),
              );
            },
          ),
        ),
      ],
    );
  }
}
