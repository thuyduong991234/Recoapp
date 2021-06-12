import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/restaurant/voucher_page.dart';

class VouchersGrid extends StatefulWidget {
  VouchersGrid();

  @override
  _VouchersGridState createState() => _VouchersGridState();
}

class _VouchersGridState extends State<VouchersGrid> {
  RestaurantBloc restaurantBloc;

  @override
  void initState() {
    super.initState();
    restaurantBloc = context.read<RestaurantBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
        bloc: restaurantBloc,
        builder: (context, state) {
          return (restaurantBloc.listVouchers != null &&
                  restaurantBloc.listVouchers.length > 0)
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: restaurantBloc.listVouchers.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (0.75),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: index % 2 == 0
                          ? EdgeInsets.only(right: 10.0, left: 10.0)
                          : EdgeInsets.only(right: 10.0, left: 10.0),
                      child: GestureDetector(
                          onTap: () => {
                                restaurantBloc.add(GetVoucherEvent(
                                    id: restaurantBloc.listVouchers[index].id)),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                                value: restaurantBloc,
                                                child: VoucherPage())))
                              },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Image
                              Container(
                                  height: 110.0,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(restaurantBloc
                                                  .listVouchers[index]
                                                  .carousel[0]))))),
                              //Restaurant name
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                      restaurantBloc.listVouchers[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0))),
                              //Vouchet and distance
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            "Ưu đãi: " +
                                                restaurantBloc
                                                    .listVouchers[index].code,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold)),
                                      )
                                    ],
                                  )),
                            ],
                          )),
                    );
                  })
              : Container(
                  alignment: Alignment.center,
                  child: Text("Chưa có ưu đãi",
                      style: TextStyle(color: kTextThirdColor, fontSize: 14.0)),
                );
        });
  }
}
