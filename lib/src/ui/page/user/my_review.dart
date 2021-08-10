import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recoapp/src/blocs/review_bloc/review_bloc.dart';
import 'package:recoapp/src/blocs/review_bloc/review_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/review/create_review_page.dart';
import 'package:recoapp/src/ui/page/review/list_review.dart';
import 'package:recoapp/src/ui/page/review/review_page.dart';
import 'package:transparent_image/transparent_image.dart';

class MyReviewPage extends StatefulWidget {
  @override
  _MyReviewPageState createState() => _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage> {
  final _scrollController = ScrollController();
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<UserBloc>().add(GetMoreUserReviewsEvent());
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
    return BlocBuilder<UserBloc, UserState>(
        bloc: userBloc,
        builder: (context, state) {
          if (userBloc.listReviews == null)
            return Scaffold(
                floatingActionButton: FloatingActionButton(
                    backgroundColor: kPrimaryColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  child: CreateReviewPage(),
                                  create: (BuildContext context) =>
                                      ReviewBloc(ReviewInitial()))));
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
                appBar: AppBar(
                  shadowColor: Colors.transparent,
                  backgroundColor: kPrimaryColor,
                  centerTitle: true,
                  title: Text(
                    'Review của tôi',
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
                ),
                body: SafeArea(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor),
                        )))));
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                  backgroundColor: kPrimaryColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                child: CreateReviewPage(),
                                create: (BuildContext context) =>
                                    ReviewBloc(ReviewInitial()))));
                  },
                  child: Stack(overflow: Overflow.visible, children: [
                    ClipOval(
                      child: Image.network(
                        userBloc.diner.avatar != null ? userBloc.diner.avatar  : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA-Jw0QFuiDlVykI47JOPtuhYbxIhnM77tkw&usqp=CAU',
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
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                title: Text(
                  'Review của tôi',
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
              ),
              body: SafeArea(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: (userBloc.listReviews != null &&
                              userBloc.listReviews.length > 0)
                          ? StaggeredGridView.countBuilder(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              itemCount: userBloc.hasReachedMax
                                  ? userBloc.listReviews.length
                                  : userBloc.listReviews.length + 1,
                              controller: _scrollController,
                              itemBuilder: (BuildContext context, index) {
                                return index >= userBloc.listReviews.length
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
                                                      BlocProvider(
                                                          child: ReviewPage(
                                                              id: userBloc
                                                                  .listReviews[
                                                                      index]
                                                                  .id),
                                                          create: (BuildContext
                                                                  context) =>
                                                              ReviewBloc(
                                                                  ReviewInitial()))));
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
                                                userBloc.listReviews[index]
                                                                .photos !=
                                                            null &&
                                                        userBloc
                                                                .listReviews[
                                                                    index]
                                                                .photos
                                                                .length >
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
                                                          image: userBloc
                                                              .listReviews[
                                                                  index]
                                                              .photos[0],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : Container(),
                                                userBloc.listReviews[index]
                                                            .title !=
                                                        null
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 5,
                                                                top: 10),
                                                        child: Text(
                                                            userBloc
                                                                .listReviews[
                                                                    index]
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
                                                              image: CachedNetworkImageProvider(userBloc
                                                                          .listReviews[
                                                                              index]
                                                                          .user
                                                                          .avatar !=
                                                                      null
                                                                  ? userBloc
                                                                      .listReviews[
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
                                                            userBloc
                                                                .listReviews[
                                                                    index]
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
                                                              userBloc
                                                                  .listReviews[
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
                              })
                          : Container(
                              child: Center(
                                  child: Text(
                              "Chưa có bài review nào",
                              style: TextStyle(
                                  color: kTextThirdColor, fontSize: 14),
                            ))))));
        });
  }
}
