import 'package:flutter/material.dart';
import 'package:recoapp/src/ui/constants.dart';

class TagChips extends StatefulWidget {
  TagChips();

  @override
  _TagChipsState createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
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
              children: List<Widget>.generate(20, (int index) {
                return ChoiceChip(
                  backgroundColor: Color(0xFFFF8A00).withOpacity(0.3),
                  selected: false,
                  onSelected: (isSelected) {},
                  labelStyle:
                      TextStyle(color: Color(0xFFFF8A00), fontSize: 14.0),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text('Lẩu'), SizedBox(width: 5), Text('(20)')],
                  ),
                );
              }),
            ))
      ],
    );
  }
}
