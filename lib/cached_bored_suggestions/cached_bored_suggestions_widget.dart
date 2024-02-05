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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            for (final suggestion in state.suggestions)
              _buildItem(
                suggestion,
                onDismissed: (_) {
                  notifier.removeByIndex(state.suggestions.indexOf(suggestion));
                },
              ),
            if (state.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: state.isLoading ? null : notifier.getNewSuggestion,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildItem(
    String suggestion, {
    void Function(DismissDirection)? onDismissed,
  }) {
    return Dismissible(
      key: ValueKey(suggestion),
      onDismissed: onDismissed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              suggestion,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
