import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_event.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/models/filter_item.dart';
import 'package:recoapp/src/models/notification.dart';
import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/models/tag.dart';
import 'package:recoapp/src/models/voucher.dart';
import 'package:recoapp/src/resources/resource/resource_repository.dart';
import 'package:recoapp/src/resources/restaurant/restaurant_repository.dart';
import 'package:recoapp/src/resources/search/search_repository.dart';
import 'package:recoapp/src/resources/tag/tag_repository.dart';
import 'package:recoapp/src/resources/voucher/voucher_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  List<FilterItem> list_data = [];
  Map<int, List<Tag>> selected = Map<int, List<Tag>>();
  List<Tag> filter = [];
  List<String> restaurants = [];
  List<String> recommendSearch = [];
  List<Tag> listTagHome = [];
  List<Restaurant> top10Restaurant = [];
  List<Voucher> top10Voucher = [];
  Tag byTag = null;
  int page = 0;
  int totalElements = 0;
  String minPrice = null;
  String maxPrice = null;
  String sortBy = null;
  String codeSort = null;
  String textSearch = "";
  int notiNumber = 0;
  List<Noti> listNoti = null;
  bool hasReachedMaxNoti = false;
  int pageNoti = 0;
  int totalPageNoti = 0;

  bool statusNoti = true;
  List<String> showHome = [
    "Có gì hot hôm nay",
    "Gợi ý cho bạn",
    "Những người khác đang xem",
    "Địa điểm uy tín",
    "Mới xem gần đây",
    "Khám phá ẩm thực"
  ];
  List<String> selectedHome = [];

  final _resourceRepository = ResourceRepository();
  final _searchRepository = SearchRepository();
  final _tagRepository = TagRepository();
  final _restaurantRepository = RestaurantRepository();
  final _voucherRepository = VoucherRepository();

  FilterBloc(FilterState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  FilterState get initialState => FilterInitial();

  @override
  Stream<FilterState> mapEventToState(event) async* {
    if (event is GetFilterEvent) {
      top10Restaurant = await _restaurantRepository.fetchTop10Restaurant();

      top10Voucher = await _voucherRepository.fetchTop10NewestVouchers();

      listTagHome = await _tagRepository.fetchAllTags();

      restaurants = await _resourceRepository.getRestaurantNames();

      list_data = await _resourceRepository.getFilterItems();

      for (int i = 0; i < list_data.length; i++) {
        selected.putIfAbsent(i, () => List<Tag>());
      }

      final prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey("showHome")) {
        selectedHome = prefs.getStringList("showHome");
      } else {
        selectedHome = List.of(showHome);
      }

      if (prefs.containsKey("isOn")) {
        statusNoti = prefs.getBool("isOn");
      } else {
        statusNoti = true;
      }

      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is SearchByTagEvent) {
      List<Restaurant> temp = [];
      yield FilterWaitingState(
          status: FilterStatus.waiting, listData: temp, hasReachedMax: false);
      filter = [];
      page = 0;
      byTag = event.tag;
      textSearch = event.tag.name;
      yield await _mapResultFetchByOneTagToState(
          state, event.tag, event.latitude, event.longtitude);
    }

    if (event is InputChangedEvent) {
      yield FilterLoadingState(
          status: FilterStatus.initial,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      recommendSearch = restaurants.where((item) {
        return item.toLowerCase().contains(event.input.toLowerCase());
      }).toList();

      yield FilterLoadedState(
          status: FilterStatus.initial,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is EnterFilterPageEvent) {
      filter = [];
      recommendSearch = restaurants;
      yield FilterLoadedState(
          status: FilterStatus.initial,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is SelectedFilterItemEvent) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      event.value == true
          ? selected[event.index].add(event.tag)
          : selected[event.index].remove(event.tag);
      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is UnSelectedFilterItemEvent) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
      if (event.unSelectedAll) {
        sortBy = null;
        codeSort = null;
        minPrice = null;
        maxPrice = null;

        for (int i = 0; i < selected.length; i++) {
          selected[i].clear();
        }
      } else {
        selected[event.index].clear();
      }
      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is SelectedSortByEvent) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      if (event.sortBy == "Khoảng cách")
        sortBy = "distance";
      else if (event.sortBy == "Giá cả")
        sortBy = "minPrice";
      else if (event.sortBy == "Đánh giá")
        sortBy = "starAverage";
      else
        sortBy = null;

      codeSort = event.sortBy;
      
      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is EnterMinPriceEvent) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
      minPrice = event.minPrice;
      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is EnterMaxPriceEvent) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
      maxPrice = event.maxPrice;
      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is StartFilterEvent) {
      List<Restaurant> temp = [];
      yield FilterWaitingState(
          status: FilterStatus.waiting, listData: temp, hasReachedMax: false);

      filter = [];
      page = 0;
      byTag = null;
      textSearch = "";

      List<int> areas = selected[0].map((e) => e.id).toList();
      List<int> dishes = selected[1].map((e) => e.id).toList();
      List<int> type = selected[2].map((e) => e.id).toList();
      List<int> nation = selected[4].map((e) => e.id).toList();

      filter.addAll(selected[0]);
      filter.addAll(selected[1]);
      filter.addAll(selected[2]);
      filter.addAll(selected[4]);

      yield await _mapResultFetchToState(state, areas, dishes, type, nation,
          sortBy, minPrice, maxPrice, event.latitude, event.longtitude);
    }

    if (event is LoadMoreResultEvent) {
      yield FilterWaitingState(
          status: FilterStatus.waiting,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      filter = [];

      if (event.byFilter == 0) {

        List<int> areas = selected[0].map((e) => e.id).toList();
        List<int> dishes = selected[1].map((e) => e.id).toList();
        List<int> type = selected[2].map((e) => e.id).toList();
        List<int> nation = selected[4].map((e) => e.id).toList();

        filter.addAll(selected[0]);
        filter.addAll(selected[1]);
        filter.addAll(selected[2]);
        filter.addAll(selected[4]);

        yield await _mapResultFetchMoreToState(
            state,
            areas,
            dishes,
            type,
            nation,
            sortBy,
            minPrice,
            maxPrice,
            event.latitude,
            event.longtitude);
      } else if (event.byFilter == 1) {
        yield await _mapResultFetchMoreByInputToState(
            state, textSearch, event.latitude, event.longtitude);
      } else {
        yield await _mapResultFetchMoreByOneTagToState(
            state, byTag, event.latitude, event.longtitude);
      }
    }

    if (event is SearchByInputTextEvent) {
      List<Restaurant> temp = [];
      yield FilterWaitingState(
          status: FilterStatus.waiting, listData: temp, hasReachedMax: false);
      filter = [];
      page = 0;
      byTag = null;
      textSearch = event.input;
      yield await _mapResultFetchByInputToState(
          state, event.input, event.latitude, event.longtitude);
    }

    if (event is FetchNotification) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      notiNumber = 0;
      pageNoti = 0;

      List<Object> result =
          await _resourceRepository.fetchNotification(event.userId, pageNoti);
      listNoti = result[0];
      totalPageNoti = result[1];

      if (totalPageNoti == pageNoti + 1)
        hasReachedMaxNoti = true;
      else
        hasReachedMaxNoti = false;

      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is FetchMoreNotification) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      if (!hasReachedMaxNoti) {
        pageNoti = pageNoti + 1;

        List<Object> result =
            await _resourceRepository.fetchNotification(event.userId, pageNoti);
        List<Noti> listNotiNew = result[0];

        if (listNotiNew.isEmpty)
          hasReachedMaxNoti = true;
        else
          listNoti = List.of(listNoti)..addAll(listNotiNew);

        yield FilterLoadedState(
            status: state.status,
            listData: state.listData,
            hasReachedMax: state.hasReachedMax);
      }
    }

    if (event is HaveNewNotification) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      notiNumber = notiNumber + 1;
      pageNoti = 0;

      List<Object> result =
          await _resourceRepository.fetchNotification(event.userId, pageNoti);
      listNoti = result[0];
      totalPageNoti = result[1];

      if (totalPageNoti == pageNoti + 1)
        hasReachedMaxNoti = true;
      else
        hasReachedMaxNoti = false;

      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is UpdateStatusNotification) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      final prefs = await SharedPreferences.getInstance();

      prefs.setInt(event.idNoti.toString(), event.idNoti);

      listNoti.elementAt(event.index).setStatus(true);

      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is SendTokenFCM) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      await _resourceRepository.sendTokenFCM(event.token);

      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is DeletedInShowHome) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      if (event.value) {
        selectedHome.add(showHome.elementAt(event.index));
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList("showHome", selectedHome);
      } else {
        selectedHome.remove(showHome.elementAt(event.index));
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList("showHome", selectedHome);
      }

      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is UpdateSetNotification) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      statusNoti = event.isOn;
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isOn", event.isOn);

      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is ReportEvent) {
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      if (event.content == null || event.content == "") {
        Fluttertoast.showToast(
            msg: "Hãy mô tả lỗi/thông tin mà bạn gặp phải.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else {
        int result = await _resourceRepository.report(
            id: event.id, content: event.content, type: event.type);
        if (result == 201) {
          Fluttertoast.showToast(
              msg: "Report thành công!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              timeInSecForIosWeb: 5);
          Navigator.of(event.context).pop();
          yield FilterLoadedState(
              status: state.status,
              listData: state.listData,
              hasReachedMax: state.hasReachedMax);
        }
      }
    }
  }

  Future<FilterState> _mapResultFetchToState(
      FilterState state,
      List<int> areas,
      List<int> dishes,
      List<int> type,
      List<int> nation,
      String sortBy,
      String minPrice,
      String maxPrice,
      double latitude,
      double longtitude) async {
        
    if (state.hasReachedMax) return state;
    try {
      final result = await _searchRepository.searchByFilter(areas, dishes, type,
          nation, minPrice, maxPrice, sortBy, 0, latitude, longtitude);
      List<Restaurant> listdata = result.elementAt(1);
      totalElements = result.elementAt(0);
      if (listdata.length == totalElements) {
        return state.copyWith(
          status: FilterStatus.success,
          listData: listdata,
          hasReachedMax: true,
        );
      }
      return state.copyWith(
        status: FilterStatus.success,
        listData: listdata,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: FilterStatus.failure);
    }
  }

  Future<FilterState> _mapResultFetchMoreToState(
      FilterState state,
      List<int> areas,
      List<int> dishes,
      List<int> type,
      List<int> nation,
      String sortBy,
      String minPrice,
      String maxPrice,
      double latitude,
      double longtitude) async {
        
    if (state.hasReachedMax) return state;
    try {
      final result = await _searchRepository.searchByFilter(areas, dishes, type,
          nation, minPrice, maxPrice, sortBy, ++page, latitude, longtitude);
      List<Restaurant> listdata = result.elementAt(1);
      totalElements = result.elementAt(0);
      
      List<Restaurant> a = List.of(state.listData)..addAll(listdata);
      
      return listdata.isEmpty
          ? state.copyWith(status: FilterStatus.success, hasReachedMax: true)
          : FilterLoadedState(
              status: FilterStatus.success,
              listData: a,
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: FilterStatus.failure);
    }
  }

  Future<FilterState> _mapResultFetchByInputToState(FilterState state,
      String input, double latitude, double longtitude) async {
    
    if (state.hasReachedMax) return state;
    try {
      final result = await _searchRepository.searchRestaurant(
          input, 0, latitude, longtitude);
      List<Restaurant> listdata = result.elementAt(1);
      totalElements = result.elementAt(0);
      if (listdata.length == totalElements) {
        return state.copyWith(
          status: FilterStatus.success,
          listData: listdata,
          hasReachedMax: true,
        );
      }
      return state.copyWith(
        status: FilterStatus.success,
        listData: listdata,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: FilterStatus.failure);
    }
  }

  Future<FilterState> _mapResultFetchMoreByInputToState(FilterState state,
      String input, double latitude, double longtitude) async {
    if (state.hasReachedMax) return state;
    try {
      final result = await _searchRepository.searchRestaurant(
          input, ++page, latitude, longtitude);
      List<Restaurant> listdata = result.elementAt(1);
      totalElements = result.elementAt(0);
      List<Restaurant> a = List.of(state.listData)..addAll(listdata);
      return listdata.isEmpty
          ? state.copyWith(status: FilterStatus.success, hasReachedMax: true)
          : FilterLoadedState(
              status: FilterStatus.success,
              listData: a,
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: FilterStatus.failure);
    }
  }

  Future<FilterState> _mapResultFetchByOneTagToState(
      FilterState state, Tag tag, double latitude, double longtitude) async {
    if (state.hasReachedMax) return state;
    try {
      final result = await _searchRepository.searchByOneTag(
          tag.id, 0, latitude, longtitude);
      List<Restaurant> listdata = result.elementAt(1);
      totalElements = result.elementAt(0);
      if (listdata.length == totalElements) {
        return state.copyWith(
          status: FilterStatus.success,
          listData: listdata,
          hasReachedMax: true,
        );
      }
      return state.copyWith(
        status: FilterStatus.success,
        listData: listdata,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: FilterStatus.failure);
    }
  }

  Future<FilterState> _mapResultFetchMoreByOneTagToState(
      FilterState state, Tag tag, double latitude, double longtitude) async {
    if (state.hasReachedMax) return state;
    try {
      final result = await _searchRepository.searchByOneTag(
          tag.id, ++page, latitude, longtitude);
      List<Restaurant> listdata = result.elementAt(1);
      totalElements = result.elementAt(0);
      List<Restaurant> a = List.of(state.listData)..addAll(listdata);
      return listdata.isEmpty
          ? state.copyWith(status: FilterStatus.success, hasReachedMax: true)
          : FilterLoadedState(
              status: FilterStatus.success,
              listData: a,
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: FilterStatus.failure);
    }
  }
}
