import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bored_suggestions/bored_suggestion/bored_suggestion_widget.dart';
import 'package:bored_suggestions/bored_suggestions/bored_suggestions_widget.dart';
import 'package:bored_suggestions/cached_bored_suggestions/cached_bored_suggestions_widget.dart';
import 'package:bored_suggestions/typed_bored_suggestion/typed_bored_suggestion_widget.dart';

void main() {
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final directory = await getApplicationDocumentsDirectory();
    Hive.defaultDirectory = directory.path;

    runApp(const ProviderScope(child: App()));
  });
}

class App extends StatelessWidget {
  const App({super.key});

  Map<String, WidgetBuilder> get _routes {
    return {
      '/': (_) => const _HomeWidget(),
      '/bored-suggestion': (_) => const BoredSuggestionWidget(),
      '/typed-bored-suggestion': (_) => const TypedBoredSuggestionWidget(),
      '/bored-suggestions': (_) => const BoredSuggestionsWidget(),
      '/cached-bored-suggestions': (_) => const CachedBoredSuggestionsWidget(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      routes: _routes,
    );
  }
}

class _HomeWidget extends StatelessWidget {
  const _HomeWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/bored-suggestion');
              },
              child: const Text('Bored Suggestion'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/typed-bored-suggestion');
              },
              child: const Text('Typed Bored Suggestion'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/bored-suggestions');
              },
              child: const Text('Bored Suggestions'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cached-bored-suggestions');
              },
              child: const Text('Cached Bored Suggestions'),
            ),
          ],
        ),
      ),
    );
  }
}
