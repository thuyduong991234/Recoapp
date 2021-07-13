import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_event.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  FilterBloc filterBloc;
  UserBloc userBloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    filterBloc = context.read<FilterBloc>();
    userBloc = context.read<UserBloc>();
    _scrollController.addListener(_onScroll);
    if (userBloc.diner == null)
      filterBloc.add(FetchNotification(userId: -1));
    else
      filterBloc.add(FetchNotification(userId: userBloc.diner.id));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      if (userBloc.diner == null)
        filterBloc.add(FetchMoreNotification(userId: -1));
      else
        filterBloc.add(FetchMoreNotification(userId: userBloc.diner.id));
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
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  "Thông báo",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                automaticallyImplyLeading: false,
              ),
              body: SafeArea(
                  child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: Text("Mới nhất",
                            style: TextStyle(
                                color: kTextThirdColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: filterBloc.listNoti == null
                        ? Center(
                            child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          ))
                        : Container(
                            color: Colors.white,
                            child: ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: filterBloc.hasReachedMaxNoti
                                    ? filterBloc.listNoti.length
                                    : filterBloc.listNoti.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return index >= filterBloc.listNoti.length
                                      ? Center(
                                          child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  kPrimaryColor),
                                        ))
                                      : GestureDetector(
                                          onTap: () => {
                                                filterBloc.add(
                                                    UpdateStatusNotification(
                                                        index: index,
                                                        idNoti: filterBloc
                                                            .listNoti[index]
                                                            .id)),
                                                if (filterBloc
                                                        .listNoti[index].type ==
                                                    1)
                                                  {}
                                                else if (filterBloc
                                                        .listNoti[index].type ==
                                                    2)
                                                  {}
                                              },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: filterBloc
                                                      .listNoti[index].status
                                                  ? Colors.white
                                                  : kPrimaryColor
                                                      .withOpacity(0.1),
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Color(0xffededed),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                filterBloc.listNoti[index]
                                                            .type ==
                                                        3
                                                    ? Container(
                                                        color:
                                                            Colors.transparent,
                                                        height: 40,
                                                        width: 40,
                                                        child: Center(
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .conciergeBell,
                                                            size: 30.0,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                        ))
                                                    : filterBloc.listNoti[index]
                                                                .type ==
                                                            4
                                                        ? Container(
                                                            color: Colors
                                                                .transparent,
                                                            height: 40,
                                                            width: 40,
                                                            child: Center(
                                                              child: Icon(
                                                                FontAwesomeIcons
                                                                    .exclamationCircle,
                                                                size: 30.0,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ))
                                                        : Image.network(
                                                            filterBloc
                                                                        .listNoti[
                                                                            index]
                                                                        .image !=
                                                                    null
                                                                ? filterBloc
                                                                    .listNoti[
                                                                        index]
                                                                    .image
                                                                : "https://media-cdn.tripadvisor.com/media/photo-s/11/97/d8/1d/restaurant-logo.jpg",
                                                            width: 40,
                                                            height: 40,
                                                            fit: BoxFit.fill,
                                                          ),
                                                SizedBox(width: 20),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        filterBloc
                                                            .listNoti[index]
                                                            .title,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                            height: 1.5,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      filterBloc.listNoti[index]
                                                                  .content !=
                                                              null
                                                          ? Text(
                                                              filterBloc
                                                                  .listNoti[
                                                                      index]
                                                                  .content,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 10,
                                                              style: TextStyle(
                                                                  height: 1.5,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13),
                                                            )
                                                          : Container(),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      filterBloc.listNoti[index]
                                                                      .time !=
                                                                  null &&
                                                              filterBloc
                                                                      .listNoti[
                                                                          index]
                                                                      .time !=
                                                                  ""
                                                          ? Row(
                                                              children: [
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .history,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 16,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    filterBloc
                                                                        .listNoti[
                                                                            index]
                                                                        .time,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        height:
                                                                            1.5,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ));
                                }),
                          ))
              ])));
        });
  }
}
