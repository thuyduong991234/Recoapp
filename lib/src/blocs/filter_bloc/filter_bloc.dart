import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_event.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/models/filter_item.dart';
import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/models/tag.dart';
import 'package:recoapp/src/resources/resource/resource_repository.dart';
import 'package:recoapp/src/resources/search/search_repository.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  List<FilterItem> list_data = [];
  Map<int, List<Tag>> selected = Map<int, List<Tag>>();
  List<Tag> filter = [];
  List<String> restaurants = [];
  List<String> recommendSearch = [];
  int page = 0;
  int totalElements = 0;
  String minPrice = null;
  String maxPrice = null;
  String sortBy = null;
  String codeSort = null;
  String textSearch = "";

  final _resourceRepository = ResourceRepository();
  final _searchRepository = SearchRepository();

  FilterBloc(FilterState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  FilterState get initialState => FilterInitial();

  @override
  Stream<FilterState> mapEventToState(event) async* {
    if (event is GetFilterEvent) {
      list_data = await _resourceRepository.getFilterItems();
      for (int i = 0; i < list_data.length; i++) {
        selected.putIfAbsent(i, () => List<Tag>());
      }

      restaurants = await _resourceRepository.getRestaurantNames();
      yield FilterLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is InputChangedEvent) {
      yield FilterLoadingState(
          status: FilterStatus.initial,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
      print("input " + event.input);
      recommendSearch = restaurants.where((item) {
        return item.toLowerCase().contains(event.input.toLowerCase());
      }).toList();

      print("recommendSearch = " + recommendSearch.toString());

      yield FilterLoadedState(
          status: FilterStatus.initial,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is EnterFilterPageEvent) {
      print("vô");
      filter = [];
      recommendSearch = restaurants;
      yield FilterLoadedState(
          status: FilterStatus.initial,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is SelectedFilterItemEvent) {
      print("vô");
      yield FilterLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
      print("vô 1");
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
        print("code 2 = " + codeSort.toString());
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
        sortBy = "DISTANCE";
      else if (event.sortBy == "Giá cả")
        sortBy = "PRICE";
      else if (event.sortBy == "Đánh giá")
        sortBy = "STAR";
      else
        sortBy = null;

      codeSort = event.sortBy;
      print("code = " + codeSort.toString());
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

      List<int> areas = selected[0].map((e) => e.id).toList();
      List<int> dishes = selected[1].map((e) => e.id).toList();
      List<int> type = selected[2].map((e) => e.id).toList();
      List<int> nation = selected[4].map((e) => e.id).toList();

      filter.addAll(selected[0]);
      filter.addAll(selected[1]);
      filter.addAll(selected[2]);
      filter.addAll(selected[4]);

      yield await _mapResultFetchToState(
          state, areas, dishes, type, nation, sortBy, minPrice, maxPrice);
    }

    if (event is LoadMoreResultEvent) {
      yield FilterWaitingState(
          status: FilterStatus.waiting,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      filter = [];

      if (event.byFilter) {
        print("page = " + page.toString());

        List<int> areas = selected[0].map((e) => e.id).toList();
        List<int> dishes = selected[1].map((e) => e.id).toList();
        List<int> type = selected[2].map((e) => e.id).toList();
        List<int> nation = selected[4].map((e) => e.id).toList();

        filter.addAll(selected[0]);
        filter.addAll(selected[1]);
        filter.addAll(selected[2]);
        filter.addAll(selected[4]);

        yield await _mapResultFetchMoreToState(
            state, areas, dishes, type, nation, sortBy, minPrice, maxPrice);
      } else {
        yield await _mapResultFetchMoreByInputToState(state, textSearch);
      }
    }

    if (event is SearchByInputTextEvent) {
      List<Restaurant> temp = [];
      yield FilterWaitingState(
          status: FilterStatus.waiting, listData: temp, hasReachedMax: false);
      filter = [];
      page = 0;
      textSearch = event.input;
      yield await _mapResultFetchByInputToState(state, event.input);
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
      String maxPrice) async {
    print("vô 2 + " + state.hasReachedMax.toString());
    if (state.hasReachedMax) return state;
    try {
      final result = await _searchRepository.searchByFilter(
          areas, dishes, type, nation, minPrice, maxPrice, sortBy, 0);
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
      String maxPrice) async {
    print("vô 2 + " + state.hasReachedMax.toString());
    if (state.hasReachedMax) return state;
    try {
      final result = await _searchRepository.searchByFilter(
          areas, dishes, type, nation, minPrice, maxPrice, sortBy, ++page);
      List<Restaurant> listdata = result.elementAt(1);
      totalElements = result.elementAt(0);
      print("list data = " + listdata.length.toString());
      List<Restaurant> a = List.of(state.listData)..addAll(listdata);
      print("list data = " + a.length.toString());
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

  Future<FilterState> _mapResultFetchByInputToState(
      FilterState state, String input) async {
    print("vô 2 _mapResultFetchByInputToState + " +
        state.hasReachedMax.toString());
    if (state.hasReachedMax) return state;
    try {
      final result = await _searchRepository.searchRestaurant(input, 0);
      List<Restaurant> listdata = result.elementAt(1);
      totalElements = result.elementAt(0);
      if (listdata.length == totalElements) {
        print("vô 3 _mapResultFetchByInputToState + " +
            state.hasReachedMax.toString());
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

  Future<FilterState> _mapResultFetchMoreByInputToState(
      FilterState state, String input) async {
    print("vô 2 + " + state.hasReachedMax.toString());
    if (state.hasReachedMax) return state;
    try {
      final result = await _searchRepository.searchRestaurant(input, ++page);
      List<Restaurant> listdata = result.elementAt(1);
      totalElements = result.elementAt(0);
      print("list data = " + listdata.length.toString());
      List<Restaurant> a = List.of(state.listData)..addAll(listdata);
      print("list data = " + a.length.toString());
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
