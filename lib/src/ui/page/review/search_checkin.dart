import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recoapp/src/blocs/checkin_bloc/checkin_bloc.dart';
import 'package:recoapp/src/blocs/checkin_bloc/checkin_event.dart';
import 'package:recoapp/src/blocs/checkin_bloc/checkin_state.dart';
import 'package:recoapp/src/ui/constants.dart';

class SearchCheckinPage extends StatefulWidget {
  @override
  _SearchCheckinPageState createState() => _SearchCheckinPageState();
}

class _SearchCheckinPageState extends State<SearchCheckinPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CheckinBloc>().add(GetCheckInEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      print("is bottom false");
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    print("is bottom " + (currentScroll >= (maxScroll * 0.9)).toString());
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CheckinBloc, CheckinState>(
        bloc: context.read<CheckinBloc>(),
        builder: (context, state) {
          if (state is CheckInInitial)
            return Scaffold(
                appBar: AppBar(
                  shadowColor: Colors.transparent,
                  centerTitle: true,
                  title: Text(
                    "Check - in",
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
                        onPressed: () {},
                        child: Text(
                          "TP HCM",
                          style: TextStyle(color: kThirdColor, fontSize: 16),
                        ))
                  ],
                ),
                body: Column(
                  children: [
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Color(
                                  int.parse('#F5F5F5'.replaceAll('#', '0xff'))),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: TextField(
                                onTap: () {},
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: kTextDisabledColor,
                                  ),
                                  hintText: "Tìm kiếm...",
                                  hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: kTextDisabledColor),
                                )),
                          )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gợi ý tìm kiếm",
                                  style: TextStyle(
                                      color: kTextThirdColor, fontSize: 14),
                                ),
                                Text(
                                  context
                                      .read<CheckinBloc>()
                                      .totalElements
                                      .toString(),
                                  style: TextStyle(
                                      color: kTextThirdColor, fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          Center(
                              child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          )),
                        ],
                      ),
                    )
                  ],
                ));
          return Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  "Check - in",
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
                      onPressed: () {},
                      child: Text(
                        "TP HCM",
                        style: TextStyle(color: kThirdColor, fontSize: 16),
                      ))
                ],
              ),
              body: Column(
                children: [
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Color(
                                int.parse('#F5F5F5'.replaceAll('#', '0xff'))),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                              onChanged: (value) {
                                context
                                    .read<CheckinBloc>()
                                    .add(SearchCheckInEvent(input: value));
                              },
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: kTextDisabledColor,
                                ),
                                hintText: "Tìm kiếm...",
                                hintStyle: TextStyle(
                                    fontSize: 14.0, color: kTextDisabledColor),
                              )),
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                      child: (state.status == CheckInStatus.success)
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return index >= state.listCheckIns.length + 1
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                kPrimaryColor),
                                      ))
                                    : (index == 0
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Gợi ý tìm kiếm",
                                                  style: TextStyle(
                                                      color: kTextThirdColor,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  context
                                                      .read<CheckinBloc>()
                                                      .totalElements
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: kTextThirdColor,
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () => {
                                                  context
                                                      .read<CheckinBloc>()
                                                      .add(SelectedCheckInEvent(
                                                          checkIn: state
                                                                  .listCheckIns[
                                                              index - 1],
                                                          value: true))
                                                },
                                            child: Container(
                                              height: 70,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: context
                                                                  .read<
                                                                      CheckinBloc>()
                                                                  .selected !=
                                                              null &&
                                                          state.listCheckIns[
                                                                  index - 1] ==
                                                              context
                                                                  .read<
                                                                      CheckinBloc>()
                                                                  .selected
                                                      ? kPrimaryColor
                                                          .withOpacity(0.1)
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              child: Row(
                                                children: [
                                                  Image.network(
                                                    state
                                                                .listCheckIns[
                                                                    index - 1]
                                                                .logo !=
                                                            null
                                                        ? state
                                                            .listCheckIns[
                                                                index - 1]
                                                            .logo
                                                        : "https://image.shutterstock.com/image-vector/grill-design-element-vintage-style-260nw-311909807.jpg",
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          state
                                                              .listCheckIns[
                                                                  index - 1]
                                                              .name,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          state
                                                              .listCheckIns[
                                                                  index - 1]
                                                              .detail,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              color:
                                                                  kTextThirdColor,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )));
                              },
                              itemCount: state.hasReachedMax
                                  ? state.listCheckIns.length + 1
                                  : state.listCheckIns.length + 2,
                              controller: _scrollController,
                            )
                          : Center(child: Text('Failure')))
                ],
              ));
        });
  }
}
