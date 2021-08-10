import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recoapp/src/blocs/tag_bloc/tag_event.dart';
import 'package:recoapp/src/blocs/tag_bloc/tag_state.dart';
import 'package:recoapp/src/models/tag.dart';
import 'package:recoapp/src/resources/tag/tag_repository.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  List<Tag> list_data = [];
  List<Tag> result = [];
  List<Tag> selected = [];
  final _tagRepository = TagRepository();

  TagBloc(TagState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  TagState get initialState => Initial();

  @override
  Stream<TagState> mapEventToState(event) async* {
    if (event is GetTagEvent) {
      list_data = await _tagRepository.fetchAllTags();
      result = list_data;

      yield TagLoadedState();
    }

    if (event is SearchTagEvent) {
      yield TagLoadingState();

      result = list_data.where((item) {
        return item.name.toLowerCase().contains(event.input.toLowerCase());
      }).toList();

      yield TagLoadedState();
    }

    if (event is SelectedTagEvent) {
      yield TagLoadingState();

      if (event.value) {
        selected.add(event.tag);
      } else
        selected.remove(event.tag);

      yield TagLoadedState();
    }
  }
}
