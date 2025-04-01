part of 'write_word_cubit.dart';

@immutable
sealed class WriteWordState {}

final class WriteWordInitial extends WriteWordState {}

final class WriteWordLoading extends WriteWordState {}

final class WriteWordSuccess extends WriteWordState {}

final class WriteWordFailed extends WriteWordState {
  final String message;

  WriteWordFailed({required this.message});
}
