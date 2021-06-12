import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/ui/constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<UserBloc, UserState>(
        bloc: userBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "Sở thích",
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
              leading: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    splashColor: kPrimaryColor,
                    icon: Icon(Icons.arrow_back_ios_rounded,
                        color: kPrimaryColor),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )),
              actions: [
                Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashColor: kPrimaryColor,
                      icon: Icon(Icons.check_rounded, color: kPrimaryColor),
                      onPressed: () {
                        userBloc.add(UpdateProfileEvent(context: context));
                      },
                    ))
              ],
            ),
            body: SafeArea(
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Khu vực",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 5.0,
                            children: List<Widget>.generate(
                                userBloc.listFilterItem[0].tags.length,
                                (int index) {
                              var tag = userBloc.listFilterItem[0].tags[index];
                              return FilterChip(
                                selected:
                                    userBloc.areas.contains(tag.id.toString()),
                                checkmarkColor: Color(0xFFFF8A00),
                                label: Text(tag.name),
                                labelStyle: TextStyle(
                                    color: Color(0xFFFF8A00), fontSize: 14.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor: Color(0xffededed),
                                onSelected: (val) {
                                  userBloc.add(
                                      SelectedAreasEvent(id: tag.id, value: val));
                                },
                                selectedColor:
                                    Color(0xFFFF8A00).withOpacity(0.3),
                              );
                            }),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Món ăn",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 5.0,
                            children: List<Widget>.generate(
                                userBloc.listFilterItem[1].tags.length,
                                (int index) {
                              var tag = userBloc.listFilterItem[1].tags[index];
                              return FilterChip(
                                selected: userBloc.tagId.contains(tag.id),
                                checkmarkColor: Color(0xFFFF8A00),
                                label: Text(tag.name),
                                labelStyle: TextStyle(
                                    color: Color(0xFFFF8A00), fontSize: 14.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor: Color(0xffededed),
                                onSelected: (val) {
                                  userBloc.add(
                                      SelectedOtherTagEvent(id: tag.id, value: val));
                                },
                                selectedColor:
                                    Color(0xFFFF8A00).withOpacity(0.3),
                              );
                            }),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Loại hình",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 5.0,
                            children: List<Widget>.generate(
                                userBloc.listFilterItem[2].tags.length,
                                (int index) {
                              var tag = userBloc.listFilterItem[2].tags[index];
                              return FilterChip(
                                selected: userBloc.tagId.contains(tag.id),
                                checkmarkColor: Color(0xFFFF8A00),
                                label: Text(tag.name),
                                labelStyle: TextStyle(
                                    color: Color(0xFFFF8A00), fontSize: 14.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor: Color(0xffededed),
                                onSelected: (val) {
                                  userBloc.add(
                                      SelectedOtherTagEvent(id: tag.id, value: val));
                                },
                                selectedColor:
                                    Color(0xFFFF8A00).withOpacity(0.3),
                              );
                            }),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Quốc gia",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 5.0,
                            children: List<Widget>.generate(
                                userBloc.listFilterItem[4].tags.length,
                                (int index) {
                              var tag = userBloc.listFilterItem[4].tags[index];
                              return FilterChip(
                                selected: userBloc.tagId.contains(tag.id),
                                checkmarkColor: Color(0xFFFF8A00),
                                label: Text(tag.name),
                                labelStyle: TextStyle(
                                    color: Color(0xFFFF8A00), fontSize: 14.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor: Color(0xffededed),
                                onSelected: (val) {
                                  userBloc.add(
                                      SelectedOtherTagEvent(id: tag.id, value: val));
                                },
                                selectedColor:
                                    Color(0xFFFF8A00).withOpacity(0.3),
                              );
                            }),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Khác",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 5.0,
                            children: List<Widget>.generate(
                                userBloc.listFilterItem[5].tags.length,
                                (int index) {
                              var tag = userBloc.listFilterItem[5].tags[index];
                              return FilterChip(
                                selected: userBloc.tagId.contains(tag.id),
                                checkmarkColor: Color(0xFFFF8A00),
                                label: Text(tag.name),
                                labelStyle: TextStyle(
                                    color: Color(0xFFFF8A00), fontSize: 14.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor: Color(0xffededed),
                                onSelected: (val) {
                                  userBloc.add(
                                      SelectedOtherTagEvent(id: tag.id, value: val));
                                },
                                selectedColor:
                                    Color(0xFFFF8A00).withOpacity(0.3),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
