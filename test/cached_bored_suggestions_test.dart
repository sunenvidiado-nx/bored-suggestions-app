import 'package:bored_suggestions/cached_bored_suggestions/cached_bored_suggestions_notifier.dart';
import 'package:bored_suggestions/cached_bored_suggestions/cached_bored_suggestions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockBox extends Mock implements Box<dynamic> {}

void main() {
  late Box box;

  setUp(() {
    box = MockBox();
  });

  group('CachedBoredSuggestionsWidget', () {
    testWidgets('should display data from box', (tester) async {
      when(() => box.isEmpty).thenReturn(false);
      when(() => box.length).thenReturn(1);
      when(() => box.getRange(0, 0)).thenReturn(['Test']);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            hiveBoxProvider.overrideWithValue(box),
          ],
          child: const MaterialApp(
            home: CachedBoredSuggestionsWidget(),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });
  });
}