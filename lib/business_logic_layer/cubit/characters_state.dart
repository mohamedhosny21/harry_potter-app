part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class MyInitial extends CharactersState {}

class OnErrorState extends CharactersState {}

class CharactersLoadingState extends CharactersState {}

class CharactersLoadedState extends CharactersState {
  final List<CharactersModel> allCharacters;

  CharactersLoadedState(this.allCharacters);
}
