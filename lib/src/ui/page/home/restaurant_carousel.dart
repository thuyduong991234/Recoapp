import 'package:flutter/material.dart';
import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/ui/constants.dart';

class RestaurantCarousel extends StatefulWidget {
  final String title;
  final List<Restaurant> listData;

  RestaurantCarousel(this.title, this.listData);

  @override
  _RestaurantCarouselState createState() => _RestaurantCarouselState();
}

class _RestaurantCarouselState extends State<RestaurantCarousel> {
  @override
  Widget build(BuildContext context) {
    return widget.listData != null && widget.listData.length > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
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
                  itemCount: widget.listData.length,
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
                                margin: index == widget.listData.length - 1
                                    ? EdgeInsets.only(right: 20.0)
                                    : EdgeInsets.only(right: 0.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(widget
                                                            .listData[index]
                                                            .carousel !=
                                                        null &&
                                                    widget.listData[index]
                                                            .carousel.length >
                                                        0
                                                ? widget
                                                    .listData[index].carousel[0]
                                                : "https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg")))),
                              ),
                              //Restaurant name
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(widget.listData[index].name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0))),
                              //Vouchet and distance
                              Padding(
                                  padding: index == widget.listData.length - 1
                                      ? EdgeInsets.only(top: 10, right: 20)
                                      : EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      widget.listData[index].newestVoucher != null ? Text("Ưu đãi: -50%",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold)) : Container(),
                                      Text(widget.listData[index].distance.toString() + " km",
                                          style: TextStyle(
                                              color: Color(0xFFFF8A00),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )),
                              //Rating
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: (widget.listData[index].starAverage !=
                                            null &&
                                        widget.listData[index].starAverage != 0)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                              widget.listData[index]
                                                              .starAverage >
                                                          0 &&
                                                      widget.listData[index]
                                                              .starAverage <
                                                          1
                                                  ? Icons.star_half
                                                  : Icons.star,
                                              color: widget.listData[index]
                                                          .starAverage <=
                                                      0
                                                  ? kTextDisabledColor
                                                  : Color(0xFFFF8A00),
                                              size: 20.0),
                                          Icon(
                                              widget.listData[index]
                                                              .starAverage >=
                                                          1 &&
                                                      widget.listData[index]
                                                              .starAverage <
                                                          2
                                                  ? Icons.star_half
                                                  : Icons.star,
                                              color: widget.listData[index]
                                                          .starAverage <
                                                      1
                                                  ? kTextDisabledColor
                                                  : Color(0xFFFF8A00),
                                              size: 20.0),
                                          Icon(
                                              widget.listData[index]
                                                              .starAverage >=
                                                          2 &&
                                                      widget.listData[index]
                                                              .starAverage <
                                                          3
                                                  ? Icons.star_half
                                                  : Icons.star,
                                              color: widget.listData[index]
                                                          .starAverage <
                                                      2
                                                  ? kTextDisabledColor
                                                  : Color(0xFFFF8A00),
                                              size: 20.0),
                                          Icon(
                                              widget.listData[index]
                                                              .starAverage >=
                                                          3 &&
                                                      widget.listData[index]
                                                              .starAverage <
                                                          4
                                                  ? Icons.star_half
                                                  : Icons.star,
                                              color: widget.listData[index]
                                                          .starAverage <
                                                      3
                                                  ? kTextDisabledColor
                                                  : Color(0xFFFF8A00),
                                              size: 20.0),
                                          Icon(
                                              widget.listData[index]
                                                              .starAverage >=
                                                          4 &&
                                                      widget.listData[index]
                                                              .starAverage <
                                                          5
                                                  ? Icons.star_half
                                                  : Icons.star,
                                              color: widget.listData[index]
                                                          .starAverage <
                                                      4
                                                  ? kTextDisabledColor
                                                  : Color(0xFFFF8A00),
                                              size: 20.0),
                                          SizedBox(width: 5),
                                          Text(
                                              "(" +
                                                  widget.listData[index]
                                                      .commentCount
                                                      .toString() +
                                                  ")",
                                              style: TextStyle(
                                                  color: kTextDisabledColor,
                                                  fontSize: 14.0)),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(Icons.star,
                                              color: kTextDisabledColor,
                                              size: 20.0),
                                          Icon(Icons.star,
                                              color: kTextDisabledColor,
                                              size: 20.0),
                                          Icon(Icons.star,
                                              color: kTextDisabledColor,
                                              size: 20.0),
                                          Icon(Icons.star,
                                              color: kTextDisabledColor,
                                              size: 20.0),
                                          Icon(Icons.star,
                                              color: kTextDisabledColor,
                                              size: 20.0),
                                          SizedBox(width: 5),
                                          Text(
                                              "(" +
                                                  widget.listData[index]
                                                      .commentCount
                                                      .toString() +
                                                  ")",
                                              style: TextStyle(
                                                  color: kTextDisabledColor,
                                                  fontSize: 14.0)),
                                        ],
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                    widget.listData[index].detailAddress,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(0xFF9A9693),
                                        fontSize: 14.0)),
                              ),
                              //tag
                              widget.listData[index].tags != null &&
                                      widget.listData[index].tags.length > 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Wrap(
                                          spacing: 8.0,
                                          children: List<Widget>.generate(
                                              widget.listData[index].tags
                                                          .length >
                                                      1
                                                  ? 2
                                                  : 1, (int index1) {
                                            return Chip(
                                              backgroundColor:
                                                  Color(0xFFFF9D7F),
                                              labelStyle: TextStyle(
                                                  color: kTextMainColor,
                                                  fontSize: 14.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              label: Text(widget.listData[index]
                                                  .tags[index1].name),
                                            );
                                          })))
                                  : Container(),
                            ],
                          )),
                    );
                  },
                ),
              ),
            ],
          )
        : Container();
  }
}
