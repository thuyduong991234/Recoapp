import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recoapp/src/blocs/review_bloc/review_bloc.dart';
import 'package:recoapp/src/blocs/review_bloc/review_event.dart';
import 'package:recoapp/src/blocs/review_bloc/review_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/review/create_review_page.dart';
import 'package:recoapp/src/ui/page/review/review_page.dart';
import 'package:transparent_image/transparent_image.dart';

class ReviewsPage extends StatefulWidget {
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final _scrollController = ScrollController();
  ReviewBloc reviewBloc;
  UserBloc userBloc;
  var textSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    reviewBloc = context.read<ReviewBloc>();
    userBloc = context.read<UserBloc>();
    _scrollController.addListener(_onScroll);
    textSearch = TextEditingController();
    print("vô" + reviewBloc.listPhotos.toString());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      print("true or false" +
          context.read<ReviewBloc>().state.hasReachedMax.toString());
      context.read<ReviewBloc>().add(GetReviewEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ReviewBloc, ReviewState>(
        bloc: reviewBloc,
        builder: (context, state) {
          if (state is ReviewInitial)
            return Scaffold(
                floatingActionButton: FloatingActionButton(
                    backgroundColor: kPrimaryColor,
                    onPressed: () {
                      if (userBloc.diner != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                      value: reviewBloc,
                                      child: CreateReviewPage(),
                                    )));
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Bạn cần đăng nhập để thực hiện chức năng này!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIosWeb: 5);
                      }
                    },
                    child: Stack(overflow: Overflow.visible, children: [
                      ClipOval(
                        child: Image.network(
                          userBloc.diner != null ? userBloc.diner.avatar : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA-Jw0QFuiDlVykI47JOPtuhYbxIhnM77tkw&usqp=CAU',
                          width: 60,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                          top: 40,
                          left: 40,
                          child: ClipOval(
                            child: Container(
                                color: Colors.white,
                                child: Icon(Icons.add_circle,
                                    color: kPrimaryColor, size: 25)),
                          ))
                    ])),
                body: SafeArea(
                  child: Column(children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      height: 100,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                      ),
                      child: Column(children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(children: <Widget>[
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Color(int.parse(
                                      '#F5F5F5'.replaceAll('#', '0xff'))),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: TextField(
                                    readOnly: true,
                                    onTap: () {},
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(int.parse(
                                          '#9A9693'.replaceAll('#', '0xff'))),
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Color(int.parse(
                                            '#9A9693'.replaceAll('#', '0xff'))),
                                      ),
                                      hintText: "Tìm kiếm...",
                                    )),
                              )),
                            ])),
                        Padding(
                            padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                            child: Text(
                              reviewBloc.totalElements.toString() +
                                  " bài review",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            )),
                      ]),
                    ),
                    Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      )),
                    ),
                  ]),
                ));
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                  backgroundColor: kPrimaryColor,
                  onPressed: () {
                    if (userBloc.diner != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                    value: reviewBloc,
                                    child: CreateReviewPage(),
                                  )));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Bạn cần đăng nhập để thực hiện chức năng này!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          timeInSecForIosWeb: 5);
                    }
                  },
                  child: Stack(overflow: Overflow.visible, children: [
                    ClipOval(
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA-Jw0QFuiDlVykI47JOPtuhYbxIhnM77tkw&usqp=CAU',
                        width: 60,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                        top: 40,
                        left: 40,
                        child: ClipOval(
                          child: Container(
                              color: Colors.white,
                              child: Icon(Icons.add_circle,
                                  color: kPrimaryColor, size: 25)),
                        ))
                  ])),
              body: SafeArea(
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    height: 100,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                    ),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Color(int.parse(
                                    '#F5F5F5'.replaceAll('#', '0xff'))),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: TextField(
                                  onSubmitted: (value) {
                                    print("text = " + textSearch.text);
                                    reviewBloc.add(SearchReviewEvent(
                                        searchBy: value, startSearch: true));
                                  },
                                  controller: textSearch,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Color(int.parse(
                                        '#9A9693'.replaceAll('#', '0xff'))),
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Color(int.parse(
                                          '#9A9693'.replaceAll('#', '0xff'))),
                                    ),
                                    hintText: "Tìm kiếm...",
                                  )),
                            )),
                          ])),
                      Padding(
                          padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                          child: Text(
                            reviewBloc.totalElements.toString() + " bài review",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          )),
                    ]),
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: StaggeredGridView.countBuilder(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              itemCount: state.hasReachedMax
                                  ? state.listData.length
                                  : state.listData.length + 1,
                              controller: _scrollController,
                              itemBuilder: (BuildContext context, index) {
                                return index >= state.listData.length
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                kPrimaryColor),
                                      ))
                                    : GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider.value(
                                                        value: reviewBloc,
                                                        child: ReviewPage(
                                                            id: state
                                                                .listData[index]
                                                                .id),
                                                      )));
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12))),
                                            child: Column(
                                              children: [
                                                state.listData[index].photos !=
                                                            null &&
                                                        state.listData[index]
                                                                .photos.length >
                                                            0
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                        child: FadeInImage
                                                            .memoryNetwork(
                                                          placeholder:
                                                              kTransparentImage,
                                                          image: state
                                                              .listData[index]
                                                              .photos[0],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : Container(),
                                                state.listData[index].title !=
                                                        null
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 5,
                                                                top: 10),
                                                        child: Text(
                                                            state
                                                                .listData[index]
                                                                .title,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    14.0)),
                                                      )
                                                    : Container(),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 5,
                                                                  top: 10,
                                                                  bottom: 10),
                                                          child: ClipOval(
                                                            child: Image(
                                                              image: CachedNetworkImageProvider(state
                                                                          .listData[
                                                                              index]
                                                                          .user
                                                                          .avatar !=
                                                                      null
                                                                  ? state
                                                                      .listData[
                                                                          index]
                                                                      .user
                                                                      .avatar
                                                                  : 'https://www.woolha.com/media/2020/03/eevee.png'),
                                                              width: 20,
                                                              height: 20,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                            state
                                                                .listData[index]
                                                                .user
                                                                .fullname,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color:
                                                                    kTextThirdColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    12.0)),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              state
                                                                  .listData[
                                                                      index]
                                                                  .like
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 3,
                                                              style: TextStyle(
                                                                  color:
                                                                      kTextDisabledColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      12.0)),
                                                          SizedBox(width: 5),
                                                          Icon(Icons.favorite,
                                                              color:
                                                                  kThirdColor,
                                                              size: 15),
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
                              }))),
                ]),
              ));
        });
  }
}
