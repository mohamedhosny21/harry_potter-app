import 'package:test_bloc/data_layer/model/characters_model.dart';
import 'package:test_bloc/data_layer/webservices/characters_webservices.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebservices;

  CharactersRepository(this.charactersWebservices);

  Future<List<CharactersModel>> getCharactersRepo() async {
    final characters = await charactersWebservices.getCharactersFromServer();
    return characters
        .map((character) => CharactersModel.fromJson(character))
        .toList();
  }
}
