import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/restaurant/restaurant_page.dart';
import 'package:recoapp/src/ui/page/restaurant/voucher_page.dart';

class CampaignCarousel extends StatefulWidget {
  CampaignCarousel();

  @override
  _CampaignCarouselState createState() => _CampaignCarouselState();
}

class _CampaignCarouselState extends State<CampaignCarousel> {
  FilterBloc filterBloc;

  @override
  void initState() {
    super.initState();
    filterBloc = context.read<FilterBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, state) {
          return filterBloc.top10Voucher.length > 0
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20.0),
                    child: Text("Có gì HOT hôm nay?",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Divider(
                    height: 5,
                    thickness: 3,
                    indent: 20,
                    endIndent: 300,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 180.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: filterBloc.top10Voucher.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              child: VoucherPage(),
                                              create: (BuildContext context) =>
                                                  RestaurantBloc(
                                                      RestaurantInitial())
                                                    ..add(GetVoucherEvent(
                                                        id: filterBloc
                                                            .top10Voucher[index]
                                                            .id)),
                                            )))
                              },
                              child: Container(
                                width: 300,
                                margin: index == 4
                                    ? EdgeInsets.only(right: 20.0)
                                    : EdgeInsets.only(right: 0.0),
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.4),
                                                    BlendMode.darken),
                                                fit: BoxFit.cover,
                                                image: NetworkImage(filterBloc
                                                    .top10Voucher[index]
                                                    .image))),
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 10.0, left: 5.0),
                                          child: Text(
                                              filterBloc
                                                  .top10Voucher[index].title,
                                              style: TextStyle(
                                                  color: kTextMainColor,
                                                  fontSize: 16.0,
                                                  letterSpacing: 1.2)),
                                        ))),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ])
              : Container();
        });
  }
}
