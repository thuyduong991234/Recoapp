import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/ui/constants.dart';

class CommentList extends StatefulWidget {
  CommentList();

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  RestaurantBloc restaurantBloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    restaurantBloc = context.read<RestaurantBloc>();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) restaurantBloc.add(GetMoreCommentEvent());
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
    return BlocBuilder<RestaurantBloc, RestaurantState>(
        bloc: restaurantBloc,
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: restaurantBloc.hasReachedMax
                  ? restaurantBloc.listComment.length
                  : restaurantBloc.listComment.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index >= restaurantBloc.listComment.length
                    ? Center(
                        child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      ))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  restaurantBloc.listComment[index].user.avatar
                                      .replaceAll(" ", ""),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: (restaurantBloc
                                                            .listComment[index]
                                                            .overallStar !=
                                                        null &&
                                                    restaurantBloc
                                                            .listComment[index]
                                                            .overallStar !=
                                                        0)
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Icon(
                                                          restaurantBloc
                                                                      .listComment[
                                                                          index]
                                                                      .overallStar >=
                                                                  1
                                                              ? Icons.star
                                                              : Icons.star_half,
                                                          color: restaurantBloc
                                                                      .listComment[
                                                                          index]
                                                                      .overallStar >=
                                                                  0
                                                              ? Color(
                                                                  0xFFFF8A00)
                                                              : kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(
                                                          restaurantBloc
                                                                      .listComment[
                                                                          index]
                                                                      .overallStar >=
                                                                  2
                                                              ? Icons.star
                                                              : Icons.star_half,
                                                          color: restaurantBloc
                                                                      .listComment[
                                                                          index]
                                                                      .overallStar >=
                                                                  1
                                                              ? Color(
                                                                  0xFFFF8A00)
                                                              : kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(
                                                          restaurantBloc
                                                                      .listComment[
                                                                          index]
                                                                      .overallStar >=
                                                                  3
                                                              ? Icons.star
                                                              : Icons.star_half,
                                                          color: restaurantBloc
                                                                      .listComment[
                                                                          index]
                                                                      .overallStar >=
                                                                  2
                                                              ? Color(
                                                                  0xFFFF8A00)
                                                              : kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(
                                                          restaurantBloc
                                                                          .listComment[
                                                                              index]
                                                                          .overallStar <
                                                                      4 &&
                                                                  restaurantBloc
                                                                          .listComment[
                                                                              index]
                                                                          .overallStar >
                                                                      3
                                                              ? Icons.star_half
                                                              : Icons.star,
                                                          color: restaurantBloc
                                                                      .listComment[
                                                                          index]
                                                                      .overallStar >=
                                                                  3
                                                              ? Color(
                                                                  0xFFFF8A00)
                                                              : kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(
                                                          restaurantBloc
                                                                          .listComment[
                                                                              index]
                                                                          .overallStar <
                                                                      5 &&
                                                                  restaurantBloc
                                                                          .listComment[
                                                                              index]
                                                                          .overallStar >
                                                                      4
                                                              ? Icons.star_half
                                                              : Icons.star,
                                                          color: restaurantBloc
                                                                      .listComment[
                                                                          index]
                                                                      .overallStar >=
                                                                  4
                                                              ? Color(
                                                                  0xFFFF8A00)
                                                              : kTextDisabledColor,
                                                          size: 15.0),
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Icon(Icons.star,
                                                          color:
                                                              kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(Icons.star,
                                                          color:
                                                              kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(Icons.star,
                                                          color:
                                                              kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(Icons.star,
                                                          color:
                                                              kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(Icons.star,
                                                          color:
                                                              kTextDisabledColor,
                                                          size: 15.0),
                                                    ],
                                                  ),
                                          ),
                                          Text(
                                            DateFormat("dd-MM-yyyy HH:mm")
                                                .format(restaurantBloc
                                                    .listComment[index]
                                                    .createdAt),
                                            style: TextStyle(
                                                color: kTextDisabledColor,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "bởi",
                                                  style: TextStyle(
                                                      color: kTextDisabledColor,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    restaurantBloc
                                                        .listComment[index]
                                                        .user
                                                        .fullname,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Level: " +
                                                restaurantBloc
                                                    .listComment[index]
                                                    .user
                                                    .level
                                                    .toString(),
                                            style: TextStyle(
                                                color: kThirdColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ]),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          restaurantBloc.listComment[index].content != null
                              ? Text(
                                  restaurantBloc.listComment[index].content,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                )
                              : Container(),
                          SizedBox(height: 10),
                          restaurantBloc.listComment[index].photos != null &&
                                  restaurantBloc
                                          .listComment[index].photos.length >
                                      0
                              ? Wrap(
                                  spacing: 5.0,
                                  runSpacing: 5.0,
                                  children: List<Widget>.generate(
                                      restaurantBloc.listComment[index].photos
                                          .length, (int count) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            restaurantBloc.listComment[index]
                                                .photos[count]
                                                .replaceAll(" ", ""),
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.fill,
                                          )),
                                    );
                                  }),
                                )
                              : Container(),
                          SizedBox(height: 10),
                          Wrap(spacing: 8.0, runSpacing: 5.0, children: [
                            Chip(
                              backgroundColor:
                                  Color(0xFFFF8A00).withOpacity(0.3),
                              labelStyle: TextStyle(
                                  color: Color(0xFFFF8A00), fontSize: 12.0),
                              label: Text("Đồ ăn: " +
                                  restaurantBloc.listComment[index].foodStar
                                      .toString()),
                            ),
                            Chip(
                              backgroundColor:
                                  Color(0xFFFF8A00).withOpacity(0.3),
                              labelStyle: TextStyle(
                                  color: Color(0xFFFF8A00), fontSize: 12.0),
                              label: Text("Dịch vụ: " +
                                  restaurantBloc.listComment[index].serviceStar
                                      .toString()),
                            ),
                            Chip(
                              backgroundColor:
                                  Color(0xFFFF8A00).withOpacity(0.3),
                              labelStyle: TextStyle(
                                  color: Color(0xFFFF8A00), fontSize: 12.0),
                              label: Text("Không gian: " +
                                  restaurantBloc
                                      .listComment[index].aimbianceStar
                                      .toString()),
                            ),
                            Chip(
                              backgroundColor:
                                  Color(0xFFFF8A00).withOpacity(0.3),
                              labelStyle: TextStyle(
                                  color: Color(0xFFFF8A00), fontSize: 12.0),
                              label: Text("Độ ồn: " +
                                  restaurantBloc.listComment[index].noiseStar
                                      .toString()),
                            )
                          ]),
                          SizedBox(height: 40),
                        ],
                      );
              },
            ),
          );
        });
  }
}
