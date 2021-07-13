import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_event.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:recoapp/src/ui/constants.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  UserBloc userBloc;
  FilterBloc filterBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
    filterBloc = context.read<FilterBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                title: Text(
                  "Cài đặt",
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
                  child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.bell,
                                color: kTextThirdColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Thông báo",
                                style: TextStyle(
                                    color: kTextThirdColor, fontSize: 18),
                              ),
                            ],
                          ),
                          Switch(
                            value: filterBloc.statusNoti,
                            onChanged: (value) {
                              filterBloc.add(UpdateSetNotification(isOn: value));
                            },
                            activeTrackColor: kPrimaryColor.withOpacity(0.5),
                            activeColor: kPrimaryColor,
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.magic,
                                color: kTextThirdColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Hiển thị Trang chủ",
                                style: TextStyle(
                                    color: kTextThirdColor, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      )),
                  Expanded(
                      child: ListView.builder(
                    itemCount: filterBloc.showHome.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        selected: true,
                        value: filterBloc.selectedHome
                                .contains(filterBloc.showHome.elementAt(index)) ? true : false,
                        activeColor: kPrimaryColor,
                        controlAffinity: ListTileControlAffinity.leading,
                        checkColor: Colors.white,
                        title: Text(
                          filterBloc.showHome[index],
                          style: TextStyle(color: Colors.black),
                        ),
                        onChanged: (val) {
                          filterBloc.add(DeletedInShowHome(index: index, value: val));
                        },
                      );
                    },
                  ))
                ]),
              )));
        });
  }
}
