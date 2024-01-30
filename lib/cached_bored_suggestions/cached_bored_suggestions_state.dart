class CachedBoredSuggestionsState {
  const CachedBoredSuggestionsState(this.isLoading, this.suggestions);

  final bool isLoading;
  final List<String> suggestions;

  CachedBoredSuggestionsState copyWith({bool? isLoading, List<String>? suggestions}) {
    return CachedBoredSuggestionsState(isLoading ?? this.isLoading, suggestions ?? this.suggestions);
  }
}
