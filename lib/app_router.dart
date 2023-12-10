import 'package:flutter/material.dart';
import 'package:test_bloc/data_layer/model/characters_model.dart';
import 'package:test_bloc/presentation_layer/screens/character_details_screen.dart';
import 'package:test_bloc/presentation_layer/screens/home_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomePage());

      case '/characters_details_page':
        final characterModel = settings.arguments as CharactersModel;
        return MaterialPageRoute(
            builder: (context) => CharacterDetails(
                  charactersModel: characterModel,
                ));
    }

    return null;
  }
}
