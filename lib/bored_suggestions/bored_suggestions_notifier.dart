import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:bored_suggestions/bored_suggestion/bored_suggestion_widget.dart';

final boredSuggestionProvider = FutureProvider.autoDispose((ref) async {
  final baseUrl = ref.read(baseUrlProvider);
  final response = await http.get(Uri.parse('$baseUrl/api/activity'));
  final json = jsonDecode(response.body) as Map;
  return json['activity']! as String;
});

class BoredSuggestionsNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  Future<void> generate() async {
    final newSuggestion = await ref.read(boredSuggestionProvider.future);

    state = [...state, newSuggestion];
  }

  void removeByIndex(int index) {
    final updatedState = state.where((suggestion) => suggestion != state[index]).toList();

    state = updatedState;
  }
}

final boredSuggestionsStateProvider = NotifierProvider<BoredSuggestionsNotifier, List<String>>(
  BoredSuggestionsNotifier.new,
);
