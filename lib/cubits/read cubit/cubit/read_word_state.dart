part of 'read_word_cubit.dart';

@immutable
sealed class ReadWordState {}

final class ReadWordInitial extends ReadWordState {}

final class ReadWordLoading extends ReadWordState {}

final class ReadWordSuccess extends ReadWordState {
  final List<WordModel> words;

  ReadWordSuccess({required this.words});
}

final class ReadWordFailed extends ReadWordState {
  final String errormsg;

  ReadWordFailed({required this.errormsg});
}
