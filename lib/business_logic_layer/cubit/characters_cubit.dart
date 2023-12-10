import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_bloc/data_layer/repository/characters_repository.dart';

import '../../data_layer/model/characters_model.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersRepository) : super(MyInitial());
  final CharactersRepository charactersRepository;

  void getCharactersCubit() {
    emit(CharactersLoadingState());
    charactersRepository.getCharactersRepo().then((value) {
      emit(CharactersLoadedState(value));
    }).catchError((onError) {
      emit(OnErrorState());
      debugPrint('Error : ' + onError.toString());
    });
  }
}
