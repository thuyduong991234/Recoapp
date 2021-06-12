import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_event.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/models/tag.dart';
import 'package:recoapp/src/ui/constants.dart';

class CheckBoxFilterList extends StatefulWidget {
  final String title;
  final int index;

  CheckBoxFilterList(this.title, this.index, {Key key}) : super(key: key);

  @override
  CheckBoxFilterListState createState() => CheckBoxFilterListState();
}

class CheckBoxFilterListState extends State<CheckBoxFilterList>
    with AutomaticKeepAliveClientMixin {
  FilterBloc filterBloc;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  //var isChecked = [false, false, false, false, false];
  var showMore = false;
  var lengthShow = 2;

  @override
  void initState() {
    super.initState();
    filterBloc = BlocProvider.of<FilterBloc>(context);
  }

  void clear() {
    /*setState(() {
      for (int i = 0; i < isChecked.length; i++) {
        if (isChecked[i] == true) isChecked[i] = false;
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, state) {
          return Material(
              color: Colors.white,
              child: Container(
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.title,
                                    style: TextStyle(
                                        inherit: false,
                                        decoration: TextDecoration.none,
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Opacity(
                                    opacity:
                                        (filterBloc.selected[widget.index] !=
                                                    null &&
                                                filterBloc
                                                        .selected[widget.index]
                                                        .length >
                                                    0)
                                            ? 1.0
                                            : 0.0,
                                    child: TextButton(
                                      onPressed: () {
                                        filterBloc.add(
                                            UnSelectedFilterItemEvent(
                                                unSelectedAll: false,
                                                index: widget.index));
                                      },
                                      child: Text("Bỏ chọn",
                                          style: TextStyle(
                                              inherit: false,
                                              decoration: TextDecoration.none,
                                              fontSize: 14.0,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold)),
                                    ))
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(right: 10, bottom: 10),
                          height: 5,
                          width: 50,
                          color: kPrimaryColor,
                        ),
                        ListView.builder(
                            addAutomaticKeepAlives: true,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: lengthShow,
                            itemBuilder: (BuildContext context, int index) {
                              Tag currentTag = filterBloc
                                  .list_data[widget.index].tags[index];
                              return Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: CheckboxListTile(
                                    selected: true,
                                    value: filterBloc.selected[widget.index] !=
                                            null
                                        ? filterBloc.selected[widget.index]
                                            .contains(currentTag)
                                        : false,
                                    activeColor: kPrimaryColor,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    checkColor: Colors.white,
                                    title: Text(
                                      currentTag.name,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onChanged: (val) {
                                      filterBloc.add(SelectedFilterItemEvent(
                                          value: val,
                                          index: widget.index,
                                          tag: currentTag));
                                    },
                                  ));
                            }),
                        Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: showMore == false
                                ? TextButton(
                                    onPressed: () {
                                      setState(() {
                                        lengthShow = filterBloc
                                            .list_data[widget.index]
                                            .tags
                                            .length;
                                        showMore = true;
                                      });
                                    },
                                    child: Text("Tải thêm",
                                        style: TextStyle(
                                            inherit: false,
                                            decoration: TextDecoration.none,
                                            fontSize: 14.0,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)))
                                : TextButton(
                                    onPressed: () {
                                      setState(() {
                                        lengthShow = 2;
                                        showMore = false;
                                      });
                                    },
                                    child: Text("Thu gọn",
                                        style: TextStyle(
                                            inherit: false,
                                            decoration: TextDecoration.none,
                                            fontSize: 14.0,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)),
                                  ))
                      ])));
        });
  }
}
