import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:bored_suggestions/bored_suggestion/bored_suggestion_widget.dart';
import 'package:bored_suggestions/cached_bored_suggestions/cached_bored_suggestions_state.dart';

class CachedBoredSuggestionsNotifier extends Notifier<CachedBoredSuggestionsState> {
  late Box _box;

  @override
  CachedBoredSuggestionsState build() {
    _box = ref.read(hiveBoxProvider);

    return CachedBoredSuggestionsState(false, _valuesInBox);
  }

  List<String> get _valuesInBox => _box.isEmpty ? [] : _box.getRange(0, _box.length - 1).cast<String>();

  Future<void> getNewSuggestion() async {
    state = state.copyWith(isLoading: true);

    final newSuggestion = await ref.read(boredSuggestionProvider.future);

    _box.add(newSuggestion);

    state = state.copyWith(isLoading: false, suggestions: _valuesInBox);
  }

  void removeByIndex(int index) {
    _box.deleteAt(index);
    state = state.copyWith(suggestions: _valuesInBox);
  }
}

final cachedBoredSuggestionsStateProvider =
    NotifierProvider<CachedBoredSuggestionsNotifier, CachedBoredSuggestionsState>(
  CachedBoredSuggestionsNotifier.new,
);

final hiveBoxProvider = Provider((ref) {
  return Hive.box();
});
