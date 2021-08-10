import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_event.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';

class UserCommentList extends StatefulWidget {
  UserCommentList();

  @override
  _UserCommentListState createState() => _UserCommentListState();
}

class _UserCommentListState extends State<UserCommentList> {
  ReservationStatusBloc reservationStatusBloc;
  final _scrollController = ScrollController();
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    reservationStatusBloc = context.read<ReservationStatusBloc>();
    userBloc = context.read<UserBloc>();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom)
      reservationStatusBloc
          .add(GetMoreEvent(type: 5, idUser: userBloc.diner.id));
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
    return BlocBuilder<ReservationStatusBloc, ReservationStatusState>(
        bloc: reservationStatusBloc,
        builder: (context, state) {
          return Container(
            //padding: EdgeInsets.all(20),
            color: Colors.white,
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: state.hasReachedMaxComment
                  ? state.listComments.length
                  : state.listComments.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.listComments.length
                    ? Center(
                        child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      ))
                    : Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    state.listComments[index].logo,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                            child: (state.listComments[index]
                                                            .overallStar !=
                                                        null &&
                                                    state.listComments[index]
                                                            .overallStar !=
                                                        0)
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Icon(
                                                          state.listComments[
                                                                          index]
                                                                      .overallStar >=
                                                                  1
                                                              ? Icons.star
                                                              : Icons.star_half,
                                                          color:
                                                              state.listComments[
                                                                          index]
                                                                      .overallStar >= 0 ? 
                                                              Color(0xFFFF8A00) : kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(
                                                          state.listComments[
                                                                          index]
                                                                      .overallStar >=
                                                                  2
                                                              ? Icons.star
                                                              : Icons.star_half,
                                                          color:
                                                              state.listComments[
                                                                          index]
                                                                      .overallStar >= 1 ? 
                                                              Color(0xFFFF8A00) : kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(
                                                          state.listComments[
                                                                          index]
                                                                      .overallStar >=
                                                                  3
                                                              ? Icons.star
                                                              : Icons.star_half,
                                                          color:
                                                              state.listComments[
                                                                          index]
                                                                      .overallStar >= 2 ? 
                                                              Color(0xFFFF8A00) : kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(
                                                          state.listComments[
                                                                          index]
                                                                      .overallStar <
                                                                  4 && state.listComments[
                                                                          index]
                                                                      .overallStar >
                                                                  3
                                                              ? Icons.star_half
                                                              : Icons.star,
                                                          color: state.listComments[
                                                                          index]
                                                                      .overallStar >= 3 ? 
                                                              Color(0xFFFF8A00) : kTextDisabledColor,
                                                          size: 15.0),
                                                      Icon(
                                                          state.listComments[
                                                                          index]
                                                                      .overallStar <
                                                                  5 && state.listComments[
                                                                          index]
                                                                      .overallStar > 4
                                                                  
                                                              ? Icons.star_half
                                                              : Icons.star,
                                                          color: state.listComments[
                                                                          index]
                                                                      .overallStar >=
                                                                  4 ? 
                                                              Color(0xFFFF8A00) : kTextDisabledColor,
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
                                                  .format(state
                                                      .listComments[index]
                                                      .createdAt),
                                              style: TextStyle(
                                                  color: kTextDisabledColor,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          state.listComments[index]
                                              .nameRestaurant,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.location_on_outlined,
                                                color: kTextDisabledColor,
                                                size: 15),
                                            Expanded(
                                              child: Text(
                                                state.listComments[index]
                                                    .detailAddress,
                                                style: TextStyle(
                                                    color: kTextDisabledColor,
                                                    fontSize: 12),
                                              ),
                                            )
                                          ],
                                        ),
                                      ]),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              state.listComments[index].content,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  height: 1.2),
                            ),
                            SizedBox(height: 10),
                            state.listComments[index].photos != null &&
                                    state.listComments[index].photos.length > 0
                                ? Wrap(
                                    spacing: 5.0,
                                    runSpacing: 5.0,
                                    children: List<Widget>.generate(
                                        state.listComments[index].photos.length,
                                        (int count) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              state.listComments[index]
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
                            Wrap(spacing: 8.0, runSpacing: 5.0, children: [
                              Chip(
                                backgroundColor:
                                    Color(0xFFFF8A00).withOpacity(0.3),
                                labelStyle: TextStyle(
                                    color: Color(0xFFFF8A00), fontSize: 12.0),
                                label: Text("Đồ ăn: " +
                                    state.listComments[index].foodStar
                                        .toString()),
                              ),
                              Chip(
                                backgroundColor:
                                    Color(0xFFFF8A00).withOpacity(0.3),
                                labelStyle: TextStyle(
                                    color: Color(0xFFFF8A00), fontSize: 12.0),
                                label: Text("Dịch vụ: " +
                                    state.listComments[index].serviceStar
                                        .toString()),
                              ),
                              Chip(
                                backgroundColor:
                                    Color(0xFFFF8A00).withOpacity(0.3),
                                labelStyle: TextStyle(
                                    color: Color(0xFFFF8A00), fontSize: 12.0),
                                label: Text("Không gian: " +
                                    state.listComments[index].aimbianceStar
                                        .toString()),
                              ),
                              Chip(
                                backgroundColor:
                                    Color(0xFFFF8A00).withOpacity(0.3),
                                labelStyle: TextStyle(
                                    color: Color(0xFFFF8A00), fontSize: 12.0),
                                label: Text("Độ ồn: " +
                                    state.listComments[index].noiseStar
                                        .toString()),
                              )
                            ]),
                          ],
                        ),
                      );
              },
            ),
          );
        });
  }
}
