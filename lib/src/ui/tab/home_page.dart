import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_event.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/home/campaign_carousel.dart';
import 'package:recoapp/src/ui/page/home/checkbox_filter_list.dart';
import 'package:recoapp/src/ui/page/home/near_you.dart';
import 'package:recoapp/src/ui/page/home/recommend_for_you_list.dart';
import 'package:recoapp/src/ui/page/home/reputation_carousel.dart';
import 'package:recoapp/src/ui/page/home/restaurant_carousel.dart';
import 'package:recoapp/src/ui/page/home/tag_chips.dart';
import 'package:recoapp/src/ui/page/search/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  FilterBloc filterBloc;

  TextEditingController textMinPrice;
  TextEditingController textMaxPrice;

  var titleSortBy = ['Khoảng cách', 'Giá cả', 'Đánh giá'];

  void clearText() {
    filterBloc.add(UnSelectedFilterItemEvent(unSelectedAll: true, index: 0));
    textMinPrice.clear();
    textMaxPrice.clear();
  }

  @override
  void initState() {
    super.initState();
    filterBloc = context.read<FilterBloc>();
    if (filterBloc.minPrice != null)
      textMinPrice = TextEditingController(text: filterBloc.minPrice);
    else
      textMinPrice = TextEditingController();

    if (filterBloc.maxPrice != null)
      textMaxPrice = TextEditingController(text: filterBloc.maxPrice);
    else
      textMaxPrice = TextEditingController();
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
                                    filterBloc.add(StartFilterEvent());

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider.value(
                                                  value: filterBloc,
                                                  child: SearchPage(),
                                                )));
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
          return Scaffold(
              body: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                              readOnly: true,
                              onTap: () {
                                filterBloc.add(EnterFilterPageEvent());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                              value: filterBloc,
                                              child: SearchPage(),
                                            )));
                              },
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
                        Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: () => {
                                          showSideSheet(
                                              context: context, rightSide: true)
                                        },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.filter_list,
                                          color: kTextMainColor,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text("Lọc",
                                            style: TextStyle(
                                              color: kTextMainColor,
                                            )),
                                      ],
                                    )))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Tất cả",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2)),
                      SizedBox(
                        width: 50,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                        value: filterBloc,
                                        child: NearYouPage(),
                                      )));
                        },
                        child: Text("Gần bạn",
                            style: TextStyle(
                                color: kTextDisabledColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      CampaignCarousel(),
                      SizedBox(height: 30),
                      RecommendForYouList(),
                      SizedBox(height: 30),
                      RestaurantCarousel("Những người khác đang xem"),
                      SizedBox(height: 30),
                      ReputationCarousel(),
                      SizedBox(height: 30),
                      RestaurantCarousel("Mới xem gần đây"),
                      SizedBox(height: 30),
                      TagChips(),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
  }
}
