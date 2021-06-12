import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/blocs/review_bloc/review_bloc.dart';
import 'package:recoapp/src/blocs/review_bloc/review_event.dart';
import 'package:recoapp/src/blocs/review_bloc/review_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/tab/home_page.dart';
import 'package:recoapp/src/ui/tab/notification_page.dart';
import 'package:recoapp/src/ui/tab/reviews_page.dart';
import 'package:recoapp/src/ui/tab/user_page.dart';

class TabNavigator extends StatefulWidget {
  final int index;

  const TabNavigator({Key key, this.index}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController;
  int _selectedIndex = 0;
  FilterBloc filterBloc;
  List<Widget> pages = [];
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    filterBloc = context.read<FilterBloc>();
    userBloc = context.read<UserBloc>();

    pages = <Widget>[
      BlocProvider.value(
        child: HomePage(),
        value: filterBloc,
      ),
      BlocProvider(
        child: ReviewsPage(),
        create: (BuildContext context) =>
            ReviewBloc(ReviewInitial())..add(GetReviewEvent()),
      ),
      NotificationPage(),
      BlocProvider.value(
        child: UserPage(),
        value: userBloc,
      ),
    ];
    _selectedIndex = widget.index ?? 0;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, state) {
          return Scaffold(
            body: PageView.builder(
              itemBuilder: (ctx, index) => pages[index],
              itemCount: pages.length,
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedLabelStyle: TextStyle(height: 2),
              unselectedLabelStyle: TextStyle(height: 2),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                _selectedIndex = index;
                _pageController.jumpToPage(index);
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(
                      FontAwesomeIcons.store,
                      size: 23.0,
                    ),
                    label: "Trang chủ"),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    FontAwesomeIcons.handPeace,
                    size: 23.0,
                  ),
                  label: "Review",
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    FontAwesomeIcons.bell,
                    size: 23.0,
                  ),
                  // ignore: deprecated_member_use
                  label: "Thông báo",
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    FontAwesomeIcons.user,
                    size: 23.0,
                  ),
                  label: "Tôi",
                ),
              ],
              elevation: 0,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: kTextDisabledColor,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              selectedFontSize: 13.0,
              unselectedFontSize: 13.0,
            ),
          );
        });
  }
}
