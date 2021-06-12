import 'package:flutter/material.dart';
import 'package:recoapp/src/ui/constants.dart';

class VoucherList extends StatefulWidget {
  VoucherList();

  @override
  _VoucherListState createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: kTextMainColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "23-04-2021, 12:45",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF9D7F)),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFF9D7F).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20)),
                              child: SizedBox(
                                height: 8,
                                width: 8,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFF9D7F),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 24,
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Flex(
                                            children: List.generate(
                                                (constraints.constrainWidth() /
                                                        6)
                                                    .floor(),
                                                (index) => SizedBox(
                                                      height: 1,
                                                      width: 3,
                                                      child: DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                      ),
                                                    )),
                                            direction: Axis.horizontal,
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20)),
                              child: SizedBox(
                                height: 8,
                                width: 8,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "4",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                                width: 100,
                                child: Text(
                                  "Thời gian",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                )),
                            Text(
                              "Giảm 50%",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            SizedBox(
                                width: 100,
                                child: Text(
                                  "Số lượng",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child:
                            Text(
                              "Giảm 50% khi đặt bàn lúc 21h",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF9A9693),
                                  fontWeight: FontWeight.bold),
                            ),
                          
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: kTextMainColor,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                          width: 10,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Color(0xFFF5F5F5)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Flex(
                                  children: List.generate(
                                      (constraints.constrainWidth() / 10)
                                          .floor(),
                                      (index) => SizedBox(
                                            height: 1,
                                            width: 5,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade400),
                                            ),
                                          )),
                                  direction: Axis.horizontal,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 10,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Color(0xFFF5F5F5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                    decoration: BoxDecoration(
                        color: kTextMainColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.restaurant, color: kPrimaryColor, size: 17,),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 200,
                          child: Text("Lẩu và nướng Yu Mei",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                        ),
                        Expanded(
                            child: TextButton(
                              onPressed: (){},
                              child: Text("Đặt lại",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFECE52)))))
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
