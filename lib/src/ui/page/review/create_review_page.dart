import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recoapp/src/blocs/checkin_bloc/checkin_bloc.dart';
import 'package:recoapp/src/blocs/checkin_bloc/checkin_event.dart';
import 'package:recoapp/src/blocs/checkin_bloc/checkin_state.dart';
import 'package:recoapp/src/blocs/tag_bloc/tag_bloc.dart';
import 'package:recoapp/src/blocs/tag_bloc/tag_event.dart';
import 'package:recoapp/src/blocs/tag_bloc/tag_state.dart';
import 'package:recoapp/src/blocs/review_bloc/review_bloc.dart';
import 'package:recoapp/src/blocs/review_bloc/review_state.dart';
import 'package:recoapp/src/blocs/review_bloc/review_event.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/review/search_checkin.dart';
import 'package:recoapp/src/ui/page/review/search_tag.dart';

class CreateReviewPage extends StatefulWidget {
  @override
  _CreateReviewPageState createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  ReviewBloc reviewBloc;
  TagBloc tagBloc;
  CheckinBloc checkinBloc;
  TextEditingController textTitle = TextEditingController();
  TextEditingController textContent = TextEditingController();
  TextEditingController textPoint = TextEditingController();

  @override
  void initState() {
    super.initState();
    reviewBloc = context.read<ReviewBloc>();
    tagBloc = TagBloc(Initial())..add(GetTagEvent());
    checkinBloc = CheckinBloc(CheckInInitial())..add(GetCheckInEvent());
    print("vô" + reviewBloc.listPhotos.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ReviewBloc, ReviewState>(
        bloc: reviewBloc,
        builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                shadowColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  "Review",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                leading: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashColor: kPrimaryColor,
                      icon: Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
                actions: [
                  TextButton(
                      onPressed: () {
                        print(
                            "tag bloc = " + tagBloc.selected.length.toString());
                        reviewBloc.add(SubmitReviewEvent(
                            context: context,
                            title: textTitle.text,
                            content: textContent.text,
                            point: textPoint.text,
                            checkIn: checkinBloc.selected,
                            tags: tagBloc.selected,
                            photos: reviewBloc.listPhotos));
                      },
                      child: Text(
                        "Đăng",
                        style: TextStyle(color: kThirdColor, fontSize: 16),
                      ))
                ],
              ),
              bottomSheet: BottomSheet(
                  onClosing: () {},
                  backgroundColor: Colors.white,
                  enableDrag: false,
                  builder: (BuildContext ctx) => Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: 10),
                              BlocBuilder<TagBloc, TagState>(
                                  bloc: tagBloc,
                                  builder: (context, state) {
                                    return tagBloc.selected.length > 0
                                        ? Wrap(
                                            spacing: 8.0,
                                            children: List<Widget>.generate(
                                                tagBloc.selected.length + 1,
                                                (int index) {
                                              return index == 0
                                                  ? Chip(
                                                      label: Text("Tag:"),
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      backgroundColor:
                                                          Colors.white,
                                                    )
                                                  : Chip(
                                                      label: Text(tagBloc
                                                          .selected[index - 1]
                                                          .name),
                                                      deleteIcon: Icon(
                                                        FontAwesomeIcons
                                                            .solidTimesCircle,
                                                        color: kTextThirdColor,
                                                        size: 20,
                                                      ),
                                                      onDeleted: () {
                                                        tagBloc.add(
                                                            SelectedTagEvent(
                                                                tag: tagBloc
                                                                        .selected[
                                                                    index - 1],
                                                                value: false));
                                                      },
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Color(0xFFFF8A00),
                                                          fontSize: 14.0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                      ),
                                                      backgroundColor:
                                                          Color(0xffededed),
                                                    );
                                            }),
                                          )
                                        : Container();
                                  }),
                              SizedBox(height: 10),
                              reviewBloc.listPhotos.length > 0
                                  ? Wrap(
                                      spacing: 5.0,
                                      runSpacing: 5.0,
                                      children: List<Widget>.generate(
                                          reviewBloc.listPhotos.length,
                                          (int index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, top: 10, bottom: 10),
                                          child: Stack(
                                            overflow: Overflow.visible,
                                            children: [
                                              Image.file(
                                                reviewBloc.listPhotos[index],
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.fill,
                                              ),
                                              Positioned(
                                                child: IconButton(
                                                  onPressed: () {
                                                    reviewBloc.add(
                                                        DeleteImageReviewEvent(
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
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext bc) {
                                              return SafeArea(
                                                child: Container(
                                                  child: Wrap(
                                                    children: <Widget>[
                                                      ListTile(
                                                          leading: Icon(Icons
                                                              .photo_library),
                                                          title:
                                                              Text('Thư viện'),
                                                          onTap: () async {
                                                            final pickedFile =
                                                                await ImagePicker()
                                                                    .getImage(
                                                                        source:
                                                                            ImageSource.gallery);
                                                            File image = File(
                                                                pickedFile
                                                                    .path);

                                                            if (image != null)
                                                              reviewBloc.add(
                                                                  UploadImageReviewEvent(
                                                                      image:
                                                                          image));

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }),
                                                      ListTile(
                                                        leading: Icon(
                                                            Icons.photo_camera),
                                                        title: Text('Camera'),
                                                        onTap: () async {
                                                          final pickedFile =
                                                              await ImagePicker()
                                                                  .getImage(
                                                                      source: ImageSource
                                                                          .camera);
                                                          File image = File(
                                                              pickedFile.path);

                                                          if (image != null)
                                                            reviewBloc.add(
                                                                UploadImageReviewEvent(
                                                                    image:
                                                                        image));

                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.image,
                                            color: kTextDisabledColor,
                                            size: 25,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Ảnh",
                                            style: TextStyle(
                                                color: kTextDisabledColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      )),
                                  SizedBox(width: 15),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider.value(
                                                      value: checkinBloc,
                                                      child:
                                                          SearchCheckinPage(),
                                                    )));
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: kTextDisabledColor,
                                            size: 25,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Check - in",
                                            style: TextStyle(
                                                color: kTextDisabledColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      )),
                                  SizedBox(width: 15),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider.value(
                                                      value: tagBloc,
                                                      child: SearchTagPage(),
                                                    )));
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.tag,
                                            color: kTextDisabledColor,
                                            size: 20,
                                          ),
                                          SizedBox(width: 5),
                                          Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text(
                                              "Gắn thẻ",
                                              style: TextStyle(
                                                  color: kTextDisabledColor,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              )
                            ]),
                      )),
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: MediaQuery.of(context).viewInsets.top),
                child: ListView(
                  children: [
                    BlocBuilder<CheckinBloc, CheckinState>(
                        bloc: checkinBloc,
                        builder: (context, state) {
                          return checkinBloc.selected != null
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 20, bottom: 10),
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: [
                                      Container(
                                        height: 70,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Row(
                                          children: [
                                            Image.network(
                                              checkinBloc.selected.logo != null
                                                  ? checkinBloc.selected.logo
                                                  : "https://media-cdn.tripadvisor.com/media/photo-s/11/97/d8/1d/restaurant-logo.jpg",
                                              width: 60,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    checkinBloc.selected.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    checkinBloc.selected.detail,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: kTextThirdColor,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        child: IconButton(
                                          onPressed: () {
                                            checkinBloc.add(
                                                SelectedCheckInEvent(
                                                    checkIn:
                                                        checkinBloc.selected,
                                                    value: false));
                                          },
                                          icon: Icon(FontAwesomeIcons
                                              .solidTimesCircle),
                                          color: Colors.black54,
                                          iconSize: 22,
                                        ),
                                        top: -20,
                                        left: 320,
                                      )
                                    ],
                                  ),
                                )
                              : Container();
                        }),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: textTitle,
                      maxLength: 100,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Nhập tiêu đề bài viết của bạn",
                          hintStyle: TextStyle(color: kTextDisabledColor)),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: textContent,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Nhập nội dung bài viết của bạn",
                          hintStyle: TextStyle(color: kTextDisabledColor)),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: textPoint,
                      maxLines: null,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^([1-9]|10)$')),
                      ],
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          helperText: "Thang điểm 10",
                          helperStyle:
                              TextStyle(color: kTextThirdColor, fontSize: 12),
                          hintText: "Nhập điểm đánh giá",
                          hintStyle: TextStyle(color: kTextDisabledColor)),
                    ),
                  ],
                ),
              )));
        });
  }
}
