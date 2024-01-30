import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bored_suggestions/bored_suggestions/bored_suggestions_notifier.dart';

class BoredSuggestionsWidget extends ConsumerWidget {
  const BoredSuggestionsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(boredSuggestionsStateProvider);
    final notifier = ref.read(boredSuggestionsStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Bored Suggestions')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          shrinkWrap: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(state[index]),
              onDismissed: (_) => notifier.removeByIndex(index),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state[index],
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: notifier.generate,
        child: const Icon(Icons.add),
      ),
    );
  }
}
