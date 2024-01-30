import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bored_suggestions/cached_bored_suggestions/cached_bored_suggestions_notifier.dart';

class CachedBoredSuggestionsWidget extends ConsumerWidget {
  const CachedBoredSuggestionsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cachedBoredSuggestionsStateProvider);
    final notifier = ref.read(cachedBoredSuggestionsStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Cached Bored Suggestions')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          shrinkWrap: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.suggestions.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(state.suggestions[index]),
              onDismissed: (_) => notifier.removeByIndex(index),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.suggestions[index],
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: state.isLoading ? null : notifier.getNewSuggestion,
        child: state.isLoading
            ? const CircularProgressIndicator.adaptive()
            : const Icon(Icons.add),
      ),
    );
  }
}
