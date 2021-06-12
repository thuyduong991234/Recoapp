import 'package:flutter/material.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/restaurant/restaurant_page.dart';

class CampaignCarousel extends StatefulWidget {
  CampaignCarousel();

  @override
  _CampaignCarouselState createState() => _CampaignCarouselState();
}

class _CampaignCarouselState extends State<CampaignCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Text("Có gì HOT hôm nay?",
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
          Container(
            height: 180.0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RestaurantPage()),
                    )
                  },
                  child: Container(
                    width: 300,
                    margin: index == 4
                        ? EdgeInsets.only(right: 20.0)
                        : EdgeInsets.only(right: 0.0),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.4),
                                        BlendMode.darken),
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg'))),
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10.0, left: 5.0),
                              child: Text(
                                  "Lẩu & Nướng Yu: CHỈ 155K COMBO THẢ GA",
                                  style: TextStyle(
                                      color: kTextMainColor,
                                      fontSize: 16.0,
                                      letterSpacing: 1.2)),
                            ))),
                  ),
                );
              },
            ),
          ),
        ],
      )
    ]);
  }
}
