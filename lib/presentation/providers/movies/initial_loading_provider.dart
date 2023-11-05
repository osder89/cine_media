import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

final initialLoaadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularMovieProvider).isEmpty;
  final step3 = ref.watch(upcomingMovieProvider).isEmpty;
  final step4 = ref.watch(topratedMovieProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true;

  return false;
});
