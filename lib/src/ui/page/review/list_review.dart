import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recoapp/src/models/simple_review.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/review/review_page.dart';
import 'package:transparent_image/transparent_image.dart';

class ListReviewWidget extends StatefulWidget {
  final List<SimpleReview> data;

  ListReviewWidget({this.data});

  @override
  _ListReviewWidgetState createState() => _ListReviewWidgetState();
}

class _ListReviewWidgetState extends State<ListReviewWidget> {
  List<String> imageList = [
    'https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/152185/1607591595_198751',
    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mjl8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80',
    'https://assets.bonappetit.com/photos/597f6564e85ce178131a6475/master/w_1200,c_limit/0817-murray-mancini-dried-tomato-pie.jpg',
    'https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/152185/1607591595_198751',
    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mjl8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80',
    'https://assets.bonappetit.com/photos/597f6564e85ce178131a6475/master/w_1200,c_limit/0817-murray-mancini-dried-tomato-pie.jpg',
    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mjl8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewPage()));
              },
              child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: imageList[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 5, top: 10),
                        child: Text("Gà lắc phô mai hút hồn giới trẻ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 5, top: 10, bottom: 10),
                                child: ClipOval(
                                  child: Image.network(
                                    'https://www.woolha.com/media/2020/03/eevee.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text("Phát Nguyễn",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: kTextThirdColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0)),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("10",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: kTextDisabledColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0)),
                                SizedBox(width: 5),
                                Icon(Icons.favorite,
                                    color: kThirdColor, size: 15),
                                SizedBox(width: 5),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )));
        },
        staggeredTileBuilder: (index) {
          return new StaggeredTile.fit(1);
        });
  }
}
