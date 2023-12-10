import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_bloc/constants/constants.dart';

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 35),
      receiveTimeout: const Duration(seconds: 35),
    );
    dio = Dio(options);
  }
  //to get characters from server
  Future<List<dynamic>> getCharactersFromServer() async {
    try {
      Response response = await dio.get('characters');

      debugPrint(response.data.toString());

      return response.data;
    } catch (error) {
      debugPrint('Error : ' + error.toString());
      return [];
    }
  }
}
