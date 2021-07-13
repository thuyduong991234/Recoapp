import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_button/group_button.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_event.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/blocs/review_bloc/review_event.dart';
import 'package:recoapp/src/blocs/review_bloc/review_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/home/checkbox_filter_list.dart';
import 'package:recoapp/src/ui/page/restaurant/restaurant_page.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  FilterBloc filterBloc;
  UserBloc userBloc;
  final _scrollController = ScrollController();

  TextEditingController textMinPrice;
  TextEditingController textMaxPrice;
  TextEditingController textSearch;

  var unfocus = true;

  var titleSortBy = ['Khoảng cách', 'Giá cả', 'Đánh giá'];

  void clearText() {
    textMinPrice.clear();
    textMaxPrice.clear();
    filterBloc.add(UnSelectedFilterItemEvent(unSelectedAll: true, index: 0));
  }

  @override
  void initState() {
    super.initState();
    filterBloc = context.read<FilterBloc>();
    userBloc = context.read<UserBloc>();
    _scrollController.addListener(_onScroll);
    if (filterBloc.minPrice != null)
      textMinPrice = TextEditingController(text: filterBloc.minPrice);
    else
      textMinPrice = TextEditingController();

    if (filterBloc.maxPrice != null)
      textMaxPrice = TextEditingController(text: filterBloc.maxPrice);
    else
      textMaxPrice = TextEditingController();

    if (filterBloc.textSearch != "") {
      textSearch = TextEditingController(text: filterBloc.textSearch);
    } else {
      textSearch = TextEditingController();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      if (filterBloc.byTag != null) {
        context.read<FilterBloc>().add(LoadMoreResultEvent(
            byFilter: 2,
            longtitude: userBloc.longtitude,
            latitude: userBloc.latitude));
      } else if (textSearch.text != null && textSearch.text.trim() != "") {
        print("textSearch = " + textSearch.text);
        context.read<FilterBloc>().add(LoadMoreResultEvent(
            byFilter: 1,
            longtitude: userBloc.longtitude,
            latitude: userBloc.latitude));
      } else {
        context.read<FilterBloc>().add(LoadMoreResultEvent(
            byFilter: 0,
            longtitude: userBloc.longtitude,
            latitude: userBloc.latitude));
      }
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

  showSideSheet({BuildContext context, bool rightSide = true}) {
    showGeneralDialog(
      barrierLabel: "barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Align(
            alignment:
                (rightSide ? Alignment.centerRight : Alignment.centerLeft),
            child: SafeArea(
              child: Container(
                  width: 300,
                  color: kBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Material(
                                color: Colors.transparent,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 25,
                                      color: kTextThirdColor,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ),
                              TextButton(
                                  onPressed: clearText,
                                  child: Text("Xóa hết",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          inherit: false,
                                          color: Colors.red,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold))),
                              TextButton(
                                  onPressed: () {
                                    textSearch.text = "";
                                    setState(() {
                                      unfocus = true;
                                    });
                                    filterBloc.add(StartFilterEvent(
                                        longtitude: userBloc.longtitude,
                                        latitude: userBloc.latitude));
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Xem kết quả",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: kSecondaryColor,
                                          fontSize: 16.0,
                                          inherit: false,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          addAutomaticKeepAlives: true,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            Container(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                color: Colors.white,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        child: Text("Sắp xếp theo",
                                            style: TextStyle(
                                                inherit: false,
                                                decoration: TextDecoration.none,
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 10),
                                        height: 5,
                                        width: 50,
                                        color: kPrimaryColor,
                                      ),
                                      Center(
                                        child: GroupButton(
                                          spacing: -1,
                                          isRadio: true,
                                          direction: Axis.horizontal,
                                          onSelected: (index, isSelected) {
                                            filterBloc.add(SelectedSortByEvent(
                                                sortBy: titleSortBy[index]));
                                          },
                                          buttons: titleSortBy,
                                          selectedButtons: [
                                            filterBloc.codeSort
                                          ],
                                          selectedTextStyle: TextStyle(
                                            fontSize: 14,
                                            color: kTextMainColor,
                                          ),
                                          unselectedTextStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                          selectedColor: kPrimaryColor,
                                          unselectedColor: Colors.white,
                                          selectedBorderColor: kPrimaryColor,
                                          unselectedBorderColor: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      )
                                    ])),
                            SizedBox(height: 10),
                            BlocProvider.value(
                                value: filterBloc,
                                child: CheckBoxFilterList("Khu vực", 0)),
                            SizedBox(height: 10),
                            BlocProvider.value(
                                value: filterBloc,
                                child: CheckBoxFilterList("Món ăn", 1)),
                            SizedBox(height: 10),
                            BlocProvider.value(
                                value: filterBloc,
                                child: CheckBoxFilterList("Loại hình", 2)),
                            SizedBox(height: 10),
                            Container(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                color: Colors.white,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        child: Text("Mức giá",
                                            style: TextStyle(
                                                inherit: false,
                                                decoration: TextDecoration.none,
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 10),
                                        height: 5,
                                        width: 50,
                                        color: kPrimaryColor,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Material(
                                                color: Colors.transparent,
                                                child: TextField(
                                                  controller: textMinPrice,
                                                  onChanged: (val) {
                                                    filterBloc.add(
                                                        EnterMinPriceEvent(
                                                            minPrice: val));
                                                  },
                                                  inputFormatters: [
                                                    CurrencyTextInputFormatter(
                                                        locale: 'vi',
                                                        decimalDigits: 0,
                                                        symbol: '')
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: 'Từ',
                                                    labelStyle:
                                                        TextStyle(fontSize: 16),
                                                    suffixText: "VND",
                                                  ),
                                                )),
                                            SizedBox(height: 10),
                                            Material(
                                                color: Colors.transparent,
                                                child: TextField(
                                                  controller: textMaxPrice,
                                                  onChanged: (val) {
                                                    filterBloc.add(
                                                        EnterMaxPriceEvent(
                                                            maxPrice: val));
                                                  },
                                                  inputFormatters: [
                                                    CurrencyTextInputFormatter(
                                                        locale: 'vi',
                                                        decimalDigits: 0,
                                                        symbol: '')
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: 'Đến',
                                                    labelStyle:
                                                        TextStyle(fontSize: 16),
                                                    suffixText: "VND",
                                                  ),
                                                )),
                                          ],
                                        ),
                                      )
                                    ])),
                            SizedBox(height: 10),
                            BlocProvider.value(
                                value: filterBloc,
                                child: CheckBoxFilterList("Quốc gia", 4)),
                          ],
                        ),
                      )
                    ],
                  )),
            ));
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset((rightSide ? 1 : -1), 0), end: Offset(0, 0))
                  .animate(animation1),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, state) {
          if (state.status == FilterStatus.initial)
            return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Material(
                            color: Colors.transparent,
                            child: IconButton(
                              splashColor: kPrimaryColor,
                              icon: Icon(Icons.arrow_back_ios_rounded,
                                  color: kPrimaryColor),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 15.0, top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: TextField(
                                readOnly: unfocus,
                                controller: textSearch,
                                onTap: () {
                                  setState(() {
                                    unfocus = false;
                                  });
                                },
                                onChanged: (value) {
                                  filterBloc
                                      .add(InputChangedEvent(input: value));
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    unfocus = true;
                                  });
                                  filterBloc.add(SearchByInputTextEvent(
                                      input: value,
                                      longtitude: userBloc.longtitude,
                                      latitude: userBloc.latitude));
                                },
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 15),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.search,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: "Tìm kiếm...",
                                    hintStyle:
                                        TextStyle(color: kTextThirdColor))),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50.0,
                      padding: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: filterBloc.filter != null &&
                                filterBloc.filter.length > 0
                            ? filterBloc.filter.length + 1
                            : 1,
                        itemBuilder: (BuildContext context, int index) {
                          return index == 0
                              ? Padding(
                                  padding: index == 0
                                      ? EdgeInsets.only(left: 15, right: 5)
                                      : EdgeInsets.only(left: 5, right: 15),
                                  child: GestureDetector(
                                      onTap: () {
                                        showSideSheet(
                                            context: context,
                                            rightSide:
                                                index == 0 ? false : true);
                                      },
                                      child: Chip(
                                        label: Icon(Icons.filter_list,
                                            color: Colors.white),
                                        backgroundColor: kPrimaryColor,
                                      )))
                              : Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Chip(
                                    label:
                                        Text(filterBloc.filter[index - 1].name),
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 14.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    backgroundColor: kPrimaryColor,
                                  ));
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: filterBloc.recommendSearch.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            return index == 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Gợi ý tìm kiếm",
                                          style: TextStyle(
                                              color: kTextThirdColor,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          filterBloc.recommendSearch.length
                                                  .toString() +
                                              " kết quả",
                                          style: TextStyle(
                                              color: kTextThirdColor,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () => {
                                          textSearch.text = filterBloc
                                              .recommendSearch[index - 1],
                                          setState(() {
                                            unfocus = true;
                                          }),
                                          filterBloc.add(SearchByInputTextEvent(
                                              input: filterBloc
                                                  .recommendSearch[index - 1],
                                              longtitude: userBloc.longtitude,
                                              latitude: userBloc.latitude))
                                        },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xffededed),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                            child: Text(
                                              filterBloc
                                                  .recommendSearch[index - 1],
                                              style: TextStyle(
                                                  color: kTextSecondColor),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 10))));
                          }),
                    )
                  ]),
                ));
          return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(children: <Widget>[
                  Row(
                    children: [
                      Material(
                          color: Colors.transparent,
                          child: IconButton(
                            splashColor: kPrimaryColor,
                            icon: Icon(Icons.arrow_back_ios_rounded,
                                color: kPrimaryColor),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.only(right: 15.0, top: 20, bottom: 20),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                              readOnly: unfocus,
                              controller: textSearch,
                              onTap: () {
                                setState(() {
                                  unfocus = false;
                                });
                              },
                              onChanged: (value) {
                                filterBloc.add(InputChangedEvent(input: value));
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  unfocus = true;
                                });
                                filterBloc.add(SearchByInputTextEvent(
                                    input: value,
                                    longtitude: userBloc.longtitude,
                                    latitude: userBloc.latitude));
                              },
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: kPrimaryColor,
                                  ),
                                  hintText: "Tìm kiếm...",
                                  hintStyle:
                                      TextStyle(color: kTextThirdColor))),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 50.0,
                    padding: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: filterBloc.filter != null &&
                              filterBloc.filter.length > 0
                          ? filterBloc.filter.length + 1
                          : 1,
                      itemBuilder: (BuildContext context, int index) {
                        return index == 0
                            ? Padding(
                                padding: index == 0
                                    ? EdgeInsets.only(left: 15, right: 5)
                                    : EdgeInsets.only(left: 5, right: 15),
                                child: GestureDetector(
                                    onTap: () {
                                      showSideSheet(
                                          context: context,
                                          rightSide: index == 0 ? false : true);
                                    },
                                    child: Chip(
                                      label: Icon(Icons.filter_list,
                                          color: Colors.white),
                                      backgroundColor: kPrimaryColor,
                                    )))
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Chip(
                                  label:
                                      Text(filterBloc.filter[index - 1].name),
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  backgroundColor: kPrimaryColor,
                                ));
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.hasReachedMax
                            ? state.listData.length + 1
                            : state.listData.length + 2,
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return index >= state.listData.length + 1
                              ? Center(
                                  child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      kPrimaryColor),
                                ))
                              : (index == 0
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Gợi ý tìm kiếm",
                                            style: TextStyle(
                                                color: kTextThirdColor,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            filterBloc.totalElements
                                                    .toString() +
                                                " kết quả",
                                            style: TextStyle(
                                                color: kTextThirdColor,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            BlocProvider(
                                                              create: (BuildContext context) => RestaurantBloc(
                                                                  RestaurantInitial())
                                                                ..add(GetRestaurantEvent(
                                                                  idUser: userBloc.diner != null ? userBloc.diner.id : null,
                                                                    longtitude:
                                                                        userBloc
                                                                            .longtitude,
                                                                    latitude:
                                                                        userBloc
                                                                            .latitude,
                                                                    id: state
                                                                        .listData[
                                                                            index -
                                                                                1]
                                                                        .id)),
                                                              child:
                                                                  RestaurantPage(),
                                                            )))
                                          },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        padding:
                                            EdgeInsets.only(right: 10, top: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xffededed),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  bottomRight:
                                                      Radius.circular(12)),
                                              child: FadeInImage.memoryNetwork(
                                                width: 140,
                                                height: 140,
                                                placeholder: kTransparentImage,
                                                image: state.listData[index - 1]
                                                                .carousel !=
                                                            null &&
                                                        state
                                                                .listData[
                                                                    index - 1]
                                                                .carousel
                                                                .length >
                                                            0
                                                    ? state.listData[index - 1]
                                                        .carousel[0]
                                                    : "https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.listData[index - 1]
                                                        .name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 5,
                                                    style: TextStyle(
                                                        height: 1.5,
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: (state
                                                                        .listData[
                                                                            index -
                                                                                1]
                                                                        .starAverage !=
                                                                    null &&
                                                                state
                                                                        .listData[
                                                                            index -
                                                                                1]
                                                                        .starAverage !=
                                                                    0)
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                      state.listData[index - 1].starAverage > 0 &&
                                                                              state.listData[index - 1].starAverage <
                                                                                  1
                                                                          ? Icons
                                                                              .star_half
                                                                          : Icons
                                                                              .star,
                                                                      color: state.listData[index - 1].starAverage <=
                                                                              0
                                                                          ? kTextDisabledColor
                                                                          : Color(
                                                                              0xFFFF8A00),
                                                                      size:
                                                                          15.0),
                                                                  Icon(
                                                                      state.listData[index - 1].starAverage >= 1 &&
                                                                              state.listData[index - 1].starAverage <
                                                                                  2
                                                                          ? Icons
                                                                              .star_half
                                                                          : Icons
                                                                              .star,
                                                                      color: state.listData[index - 1].starAverage <
                                                                              1
                                                                          ? kTextDisabledColor
                                                                          : Color(
                                                                              0xFFFF8A00),
                                                                      size:
                                                                          15.0),
                                                                  Icon(
                                                                      state.listData[index - 1].starAverage >= 2 &&
                                                                              state.listData[index - 1].starAverage <
                                                                                  3
                                                                          ? Icons
                                                                              .star_half
                                                                          : Icons
                                                                              .star,
                                                                      color: state.listData[index - 1].starAverage <
                                                                              2
                                                                          ? kTextDisabledColor
                                                                          : Color(
                                                                              0xFFFF8A00),
                                                                      size:
                                                                          15.0),
                                                                  Icon(
                                                                      state.listData[index - 1].starAverage >= 3 &&
                                                                              state.listData[index - 1].starAverage <
                                                                                  4
                                                                          ? Icons
                                                                              .star_half
                                                                          : Icons
                                                                              .star,
                                                                      color: state.listData[index - 1].starAverage <
                                                                              3
                                                                          ? kTextDisabledColor
                                                                          : Color(
                                                                              0xFFFF8A00),
                                                                      size:
                                                                          15.0),
                                                                  Icon(
                                                                      state.listData[index - 1].starAverage >= 4 &&
                                                                              state.listData[index - 1].starAverage <
                                                                                  5
                                                                          ? Icons
                                                                              .star_half
                                                                          : Icons
                                                                              .star,
                                                                      color: state.listData[index - 1].starAverage <
                                                                              4
                                                                          ? kTextDisabledColor
                                                                          : Color(
                                                                              0xFFFF8A00),
                                                                      size:
                                                                          15.0),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                      "(" +
                                                                          state
                                                                              .listData[index -
                                                                                  1]
                                                                              .commentCount
                                                                              .toString() +
                                                                          ")",
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextDisabledColor,
                                                                          fontSize:
                                                                              12.0)),
                                                                ],
                                                              )
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color:
                                                                          kTextDisabledColor,
                                                                      size:
                                                                          15.0),
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color:
                                                                          kTextDisabledColor,
                                                                      size:
                                                                          15.0),
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color:
                                                                          kTextDisabledColor,
                                                                      size:
                                                                          15.0),
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color:
                                                                          kTextDisabledColor,
                                                                      size:
                                                                          15.0),
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color:
                                                                          kTextDisabledColor,
                                                                      size:
                                                                          15.0),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                      "(" +
                                                                          state
                                                                              .listData[index -
                                                                                  1]
                                                                              .commentCount
                                                                              .toString() +
                                                                          ")",
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextDisabledColor,
                                                                          fontSize:
                                                                              12.0)),
                                                                ],
                                                              ),
                                                      ),
                                                      Text(
                                                          state
                                                                  .listData[
                                                                      index - 1]
                                                                  .distance
                                                                  .toString() +
                                                              " km",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFFF8A00),
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  state.listData[index - 1]
                                                              .newestVoucher !=
                                                          null
                                                      ? Text(
                                                          "Ưu đãi: " +
                                                              state
                                                                  .listData[
                                                                      index - 1]
                                                                  .newestVoucher,
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                      : Container(),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      state.listData[index - 1]
                                                          .detailAddress,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF9A9693),
                                                          fontSize: 12.0)),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      ((state
                                                                  .listData[
                                                                      index - 1]
                                                                  .tags
                                                                  .map((e) =>
                                                                      e.name)
                                                                  .toString())
                                                              .replaceAll(
                                                                  "(", ""))
                                                          .replaceAll(")", ""),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: kThirdColor)),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )));
                        }),
                  )
                ]),
              ));
        });
  }
}
