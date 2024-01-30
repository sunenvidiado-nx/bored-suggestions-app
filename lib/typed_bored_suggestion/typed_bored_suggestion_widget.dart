import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:bored_suggestions/bored_suggestion/bored_suggestion_widget.dart';

enum SuggestionType { recreational, relaxation, education }

final typedBoredSuggestionProvider = FutureProvider.family((ref, SuggestionType type) async {
  final baseUrl = ref.read(baseUrlProvider);
  final response = await http.get(Uri.parse('$baseUrl/api/activity?type=${type.name}'));
  final json = jsonDecode(response.body) as Map;
  return json['activity']! as String;
});

class TypedBoredSuggestionWidget extends ConsumerWidget {
  const TypedBoredSuggestionWidget({super.key});

  final type = SuggestionType.recreational;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(typedBoredSuggestionProvider(type));

    return Scaffold(
      appBar: AppBar(title: const Text('Typed Bored Suggestion')),
      body: state.when(
        data: (data) => Center(child: Text(data, style: const TextStyle(fontSize: 30))),
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
