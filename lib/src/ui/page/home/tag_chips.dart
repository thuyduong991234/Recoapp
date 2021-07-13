import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_event.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/search/search.dart';

class TagChips extends StatefulWidget {
  TagChips();

  @override
  _TagChipsState createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {
  FilterBloc filterBloc;
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    filterBloc = context.read<FilterBloc>();
    userBloc = context.read<UserBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, state) {
          return filterBloc.listTagHome != null &&
                  filterBloc.listTagHome.length > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20.0),
                      child: Text("Khám phá ẩm thực",
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
                    Container(
                        padding: EdgeInsets.only(left: 20, right: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 5.0,
                          children: List<Widget>.generate(
                              filterBloc.listTagHome.length, (int index) {
                            return ChoiceChip(
                              backgroundColor:
                                  Color(0xFFFF8A00).withOpacity(0.3),
                              selected: false,
                              onSelected: (isSelected) {
                                filterBloc.add(SearchByTagEvent(
                                    tag: filterBloc.listTagHome[index],
                                    longtitude: userBloc.longtitude,
                                    latitude: userBloc.latitude));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                              value: filterBloc,
                                              child: SearchPage(),
                                            )));
                              },
                              labelStyle: TextStyle(
                                  color: Color(0xFFFF8A00), fontSize: 14.0),
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(filterBloc.listTagHome[index].name),
                                  SizedBox(width: 5),
                                  Text('(' +
                                      filterBloc.listTagHome[index].countTag
                                          .toString() +
                                      ')')
                                ],
                              ),
                            );
                          }),
                        ))
                  ],
                )
              : Container();
        });
  }
}
