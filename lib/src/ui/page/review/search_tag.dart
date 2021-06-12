import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recoapp/src/blocs/tag_bloc/tag_bloc.dart';
import 'package:recoapp/src/blocs/tag_bloc/tag_event.dart';
import 'package:recoapp/src/blocs/tag_bloc/tag_state.dart';
import 'package:recoapp/src/ui/constants.dart';

class SearchTagPage extends StatefulWidget {
  @override
  _SearchTagPageState createState() => _SearchTagPageState();
}

class _SearchTagPageState extends State<SearchTagPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<TagBloc, TagState>(builder: (context, state) {
      if (state is Initial)
        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "Gắn thẻ",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            leading: Material(
                color: Colors.transparent,
                child: IconButton(
                  splashColor: kPrimaryColor,
                  icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
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
                        color:
                            Color(int.parse('#F5F5F5'.replaceAll('#', '0xff'))),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                          onChanged: (value) {
                            context
                                .read<TagBloc>()
                                .add(SearchTagEvent(input: value));
                          },
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
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
                child: ListView(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gợi ý tìm kiếm",
                            style:
                                TextStyle(color: kTextThirdColor, fontSize: 14),
                          ),
                          Text(
                            context.read<TagBloc>().list_data.length.toString(),
                            style:
                                TextStyle(color: kTextThirdColor, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    )),
                  ],
                ),
              )
            ],
          ),
        );
      return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Gắn thẻ",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          leading: Material(
              color: Colors.transparent,
              child: IconButton(
                splashColor: kPrimaryColor,
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
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
                      color:
                          Color(int.parse('#F5F5F5'.replaceAll('#', '0xff'))),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextField(
                        onChanged: (value) {
                          context
                              .read<TagBloc>()
                              .add(SearchTagEvent(input: value));
                        },
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
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
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Gợi ý tìm kiếm",
                          style:
                              TextStyle(color: kTextThirdColor, fontSize: 14),
                        ),
                        Text(
                          context.read<TagBloc>().result.length.toString(),
                          style:
                              TextStyle(color: kTextThirdColor, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 5.0,
                      children: List<Widget>.generate(
                          context.read<TagBloc>().result.length,
                          (int index) {
                            var tag = context.read<TagBloc>().result[index];
                        return FilterChip(
                          selected: context.read<TagBloc>().selected.contains(tag),
                          checkmarkColor: Color(0xFFFF8A00),
                          label: Text(
                              context.read<TagBloc>().result[index].name),
                          labelStyle: TextStyle(
                              color: Color(0xFFFF8A00), fontSize: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: Color(0xffededed),
                          onSelected: (val) {
                            context
                              .read<TagBloc>()
                              .add(SelectedTagEvent(tag: tag, value: val));
                          },
                          selectedColor: Color(0xFFFF8A00).withOpacity(0.3),
                        );
                      }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
