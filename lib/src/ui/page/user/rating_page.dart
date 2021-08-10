import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recoapp/src/blocs/user_bloc/rating_bloc/rating_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/rating_bloc/rating_event.dart';
import 'package:recoapp/src/blocs/user_bloc/rating_bloc/rating_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/ui/constants.dart';

class RatingPage extends StatefulWidget {
  final int idRestaurant;
  final int idReservation;

  RatingPage({this.idReservation, this.idRestaurant});
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int starFood;
  int starService;
  int starAmbious;
  int starNoise;
  TextEditingController textComment = TextEditingController();
  RatingBloc ratingBloc;
  FocusNode myFocusNode;
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    ratingBloc = context.read<RatingBloc>();
    userBloc = context.read<UserBloc>();
    myFocusNode = FocusNode();
    starFood = 5;
    starService = 5;
    starAmbious = 5;
    starNoise = 5;
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocBuilder<RatingBloc, RatingState>(
        bloc: ratingBloc,
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: kPrimaryColor,
                shadowColor: Colors.transparent,
                leading: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashColor: kPrimaryColor,
                      icon: Icon(Icons.close_rounded, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
                title: Column(
                  children: [
                    Text("ĐÁNH GIÁ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              body: SafeArea(
                  child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(20.0),
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Center(
                            child: Text("Đồ ăn",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starFood >= 1
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starFood = 1;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starFood >= 2
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starFood = 2;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starFood >= 3
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starFood = 3;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starFood >= 4
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starFood = 4;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starFood == 5
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starFood = 5;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Center(
                            child: Text("Dịch vụ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starService >= 1
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starService = 1;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starService >= 2
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starService = 2;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starService >= 3
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starService = 3;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starService >= 4
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starService = 4;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starService == 5
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starService = 5;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Center(
                            child: Text("Không gian",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starAmbious >= 1
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starAmbious = 1;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starAmbious >= 2
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starAmbious = 2;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starAmbious >= 3
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starAmbious = 3;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starAmbious >= 4
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starAmbious = 4;
                                    });
                                  }),
                            ),
                            Material(
                              color: Colors.white,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: Icon(
                                      starAmbious == 5
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Color(0xFFFF8A00)),
                                  onPressed: () {
                                    setState(() {
                                      starAmbious = 5;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Center(
                            child: Text("Độ ồn",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FlatButton(
                              minWidth: 30,
                              height: 60,
                              color: starNoise >= 1
                                  ? Color(0xFFFF8A00)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  side: BorderSide(
                                      color: Color(0xFFFF8A00), width: 2)),
                              onPressed: () {
                                setState(() {
                                  starNoise = 1;
                                });
                              },
                            ),
                            FlatButton(
                              minWidth: 30,
                              height: 50,
                              color: starNoise >= 2
                                  ? Color(0xFFFF8A00)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  side: BorderSide(
                                      color: Color(0xFFFF8A00), width: 2)),
                              onPressed: () {
                                setState(() {
                                  starNoise = 2;
                                });
                              },
                            ),
                            FlatButton(
                              minWidth: 30,
                              height: 40,
                              color: starNoise >= 3
                                  ? Color(0xFFFF8A00)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  side: BorderSide(
                                      color: Color(0xFFFF8A00), width: 2)),
                              onPressed: () {
                                setState(() {
                                  starNoise = 3;
                                });
                              },
                            ),
                            FlatButton(
                              minWidth: 30,
                              height: 30,
                              color: starNoise >= 4
                                  ? Color(0xFFFF8A00)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  side: BorderSide(
                                      color: Color(0xFFFF8A00), width: 2)),
                              onPressed: () {
                                setState(() {
                                  starNoise = 4;
                                });
                              },
                            ),
                            FlatButton(
                              minWidth: 30,
                              height: 20,
                              color: starNoise >= 5
                                  ? Color(0xFFFF8A00)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  side: BorderSide(
                                      color: Color(0xFFFF8A00), width: 2)),
                              onPressed: () {
                                setState(() {
                                  starNoise = 5;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          child: Text("Bình luận",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10, bottom: 10),
                          height: 3,
                          width: 50,
                          color: kPrimaryColor,
                        ),
                        TextField(
                          focusNode: myFocusNode,
                          controller: textComment,
                          textAlign: TextAlign.justify,
                          style: TextStyle(height: 1.5),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              hintMaxLines: 3,
                              hintText:
                                  "Bình luận của bạn sẽ được hiển thị trên ReCo và giúp người khác có cái nhìn tổng quan về nhà hàng này",
                              hintStyle: TextStyle(
                                  color: kTextDisabledColor, fontSize: 14)),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, top: 5),
                    padding: EdgeInsets.only(
                        left: 10, right: 20, top: 10, bottom: 20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              myFocusNode.unfocus();
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext bc) {
                                    return SafeArea(
                                      child: Container(
                                        child: Wrap(
                                          children: <Widget>[
                                            ListTile(
                                                leading:
                                                    Icon(Icons.photo_library),
                                                title: Text('Thư viện'),
                                                onTap: () async {
                                                  final pickedFile =
                                                      await ImagePicker()
                                                          .getImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                  File image =
                                                      File(pickedFile.path);

                                                  if (image != null)
                                                    ratingBloc.add(
                                                        UploadImageRatingEvent(
                                                            image: image));

                                                  Navigator.of(context).pop();
                                                }),
                                            ListTile(
                                              leading: Icon(Icons.photo_camera),
                                              title: Text('Camera'),
                                              onTap: () async {
                                                final pickedFile =
                                                    await ImagePicker()
                                                        .getImage(
                                                            source: ImageSource
                                                                .camera);
                                                File image =
                                                    File(pickedFile.path);

                                                if (image != null)
                                                  ratingBloc.add(
                                                      UploadImageRatingEvent(
                                                          image: image));

                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate,
                                  color: kPrimaryColor,
                                  size: 30,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Thêm hình ảnh",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                        ratingBloc.listPhotos.length > 0
                            ? Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                children: List<Widget>.generate(
                                    ratingBloc.listPhotos.length, (int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10),
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: [
                                        Image.file(
                                          ratingBloc.listPhotos[index],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.fill,
                                        ),
                                        Positioned(
                                          child: IconButton(
                                            onPressed: () {
                                              ratingBloc.add(
                                                  DeleteImageRatingEvent(
                                                      index: index));
                                            },
                                            icon: Icon(FontAwesomeIcons
                                                .solidTimesCircle),
                                            color: Colors.black54,
                                            iconSize: 20,
                                          ),
                                          top: -20,
                                          left: 56,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              )),
              bottomNavigationBar: Container(
                color: Colors.white,
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                child: FlatButton(
                  onPressed: () {
                    ratingBloc.add(SubmitRatingEvent(
                        idUser: userBloc.diner.id,
                        context: context,
                        starFood: starFood,
                        starService: starService,
                        starAmbious: starAmbious,
                        starNoise: starNoise,
                        comment: textComment.text,
                        photos: ratingBloc.listPhotos,
                        idRestaurant: widget.idRestaurant,
                        idReservation: widget.idReservation));

                    userBloc.add(CalRecommendCollabEvent());
                  },
                  color: kThirdColor,
                  textColor: Colors.white,
                  child: Text("ĐĂNG ĐÁNH GIÁ"),
                ),
              ));
        });
  }
}
