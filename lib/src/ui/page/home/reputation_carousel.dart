import 'package:flutter/material.dart';
import 'package:recoapp/src/ui/constants.dart';

class ReputationCarousel extends StatefulWidget {
  ReputationCarousel();

  @override
  _ReputationCarouselState createState() => _ReputationCarouselState();
}

class _ReputationCarouselState extends State<ReputationCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: Text("Địa điểm uy tín",
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
              height: 250.0,
              child: GridView.builder(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => {},
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: kTextMainColor),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Image(
                                  image: NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/vi/thumb/7/7e/Logo_KFC.svg/1200px-Logo_KFC.svg.png"),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 5.0, right: 5.0),
                                  child: Text("Lẩu Riki",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0))),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 5.0, right: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.star,
                                          color: Color(0xFFFF8A00), size: 15.0),
                                      SizedBox(width: 5),
                                      Text("4/",
                                          style: TextStyle(
                                              color: Color(0xFF9A9693),
                                              fontSize: 13.0)),
                                      Text("5 - 1 khuyến mãi",
                                          style: TextStyle(
                                              color: kTextDisabledColor,
                                              fontSize: 13.0)),
                                    ],
                                  )),
                            ],
                          )),
                    );
                  }))
        ]);
  }
}
