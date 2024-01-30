import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final baseUrlProvider = Provider((ref) {
  return 'https://www.boredapi.com';
});

final boredSuggestionProvider = FutureProvider.autoDispose((ref) async {
  final baseUrl = ref.read(baseUrlProvider);
  final response = await http.get(Uri.parse('$baseUrl/api/activity'));
  final json = jsonDecode(response.body) as Map;
  return json['activity']! as String;
});

class BoredSuggestionWidget extends ConsumerWidget {
  const BoredSuggestionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(boredSuggestionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Bored Suggestion')),
      body: state.when(
        data: (data) => Center(child: Text(data, style: const TextStyle(fontSize: 30))),
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
