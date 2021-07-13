import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_event.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/ui/constants.dart';

class ReportPage extends StatefulWidget {
  final int id;
  final int type;

  ReportPage({this.id, this.type});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  FilterBloc filterBloc;
  final textOther = TextEditingController();

  List<String> reportList = [
    'Nhà hàng đã chuyển/đóng cửa',
    'Sai địa chỉ, bản đồ',
    'Sai thông tin liên lạc',
    'Khuyến mãi đã dừng',
    'Nhà hàng từ chối áp dụng khuyến mãi',
    'Không áp dụng đúng theo chương trình',
    'Review vi phạm tiêu chuẩn cộng đồng',
    'Khác'
  ];

  String selected = "Nhà hàng đã chuyển/đóng cửa";

  bool readOnly = true;

  @override
  void initState() {
    super.initState();
    filterBloc = context.read<FilterBloc>();
    readOnly = true;
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
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: kPrimaryColor,
                shadowColor: Colors.transparent,
                leading: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashColor: kPrimaryColor,
                      icon: Icon(Icons.close_rounded, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
                title: Text("BÁO SAI THÔNG TIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),
              ),
              body: SafeArea(
                  child: ListView.builder(
                      itemCount: reportList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return index != reportList.length - 1
                            ? RadioListTile(
                                activeColor: kThirdColor,
                                title: Text(reportList[index]),
                                value: reportList[index],
                                groupValue: selected,
                                onChanged: (value) {
                                  print("value = " + value);
                                  setState(() {
                                    selected = value;
                                    readOnly = true;
                                  });
                                },
                              )
                            : Column(
                                children: [
                                  RadioListTile(
                                    activeColor: kThirdColor,
                                    title: Text(reportList[index]),
                                    value: reportList[index],
                                    groupValue: selected,
                                    onChanged: (value) {
                                      print("value = " + value);
                                      setState(() {
                                        selected = value;
                                        readOnly = false;
                                      });
                                    },
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: TextField(
                                        autofocus: true,
                                        readOnly: readOnly,
                                        maxLines: 5,
                                        maxLength: 1000,
                                        controller: textOther,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kTextThirdColor),
                                            ),
                                            border: OutlineInputBorder(),
                                            hintText:
                                                "Mô tả lỗi/thông tin sai mà bạn gặp phải",
                                            hintStyle: TextStyle(
                                                color: kTextDisabledColor)),
                                      )),
                                ],
                              );
                      })),
              bottomNavigationBar: Container(
                color: Colors.white,
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                child: FlatButton(
                  onPressed: () {
                    if (selected == "Khác") {
                      filterBloc.add(ReportEvent(
                          id: widget.id,
                          type: widget.type,
                          context: context,
                          content: textOther.text));
                    } else {
                      filterBloc.add(ReportEvent(
                          id: widget.id,
                          type: widget.type,
                          context: context,
                          content: selected));
                    }
                  },
                  color: kThirdColor,
                  textColor: Colors.white,
                  child: Text('GỬI'),
                ),
              ));
        });
  }
}
