import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_bloc/business_logic_layer/cubit/characters_cubit.dart';
import 'package:test_bloc/business_logic_layer/cubit/internet_cubit.dart';
import 'package:test_bloc/data_layer/model/characters_model.dart';
import 'package:test_bloc/presentation_layer/widgets/characters_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getCharactersCubit();
  }

  late List<CharactersModel> _allCharacters;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  late List<CharactersModel> _searchedCharacters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: _isSearching ? buildSearchField() : appBarTitle(),
        backgroundColor: Colors.amber,
        actions: _appBarActions(),
      ),
      body: BlocConsumer<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state is InternetConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.signal_wifi_4_bar_outlined,
                  color: Colors.amber,
                ),
                SizedBox(
                  width: 10.0.w,
                ),
                Text(
                  state.message,
                  style: TextStyle(fontSize: 20.0.sp, color: Colors.amber),
                ),
              ],
            )));
          } else if (state is InternetDisconnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.signal_wifi_connected_no_internet_4_outlined,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 10.0.w,
                  ),
                  Text(state.message,
                      style: TextStyle(fontSize: 20.0.sp, color: Colors.amber)),
                ],
              ),
            ));
          }
        },
        builder: (context, state) {
          return BlocBuilder<CharactersCubit, CharactersState>(
            builder: (context, state) {
              if (state is CharactersLoadingState) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                ));
              } else if (state is CharactersLoadedState) {
                _allCharacters = state.allCharacters;
                return GridView.builder(
                    padding: const EdgeInsetsDirectional.all(10.0),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0.h,
                        mainAxisSpacing: 5.0.w),
                    itemCount: _searchController.text.isEmpty
                        ? _allCharacters.length
                        : _searchedCharacters.length,
                    itemBuilder: (context, index) => CharactersWidget(
                        //or state.allCharacters[index]
                        charactersModel: _searchController.text.isEmpty
                            ? _allCharacters[index]
                            : _searchedCharacters[index]));
              }
              // else if (state is InternetDisconnectedState) {
              //   return const Center(
              //       child: Text(
              //     'No Internet',
              //     style: TextStyle(
              //         fontSize: 100.0,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.amber),
              //   ));
              // }

              return Center(
                  child: Text(
                'Error : No Data',
                style: TextStyle(fontSize: 25.0.sp, color: Colors.amber),
              ));
            },
          );
        },
      ),
    );
  }

  //widget for search field
  Widget buildSearchField() {
    return TextField(
      style: TextStyle(color: Colors.white, fontSize: 20.0.sp),
      controller: _searchController,
      cursorColor: Colors.white,
      decoration: InputDecoration(
          hintText: 'Search for a character',
          hintStyle: TextStyle(color: Colors.white, fontSize: 20.0.sp),
          border: InputBorder.none),
      onChanged: (searchedWord) {
        setState(() {
          _addCharactersToSearchedList(searchedWord);
        });
      },
    );
  }

//function to add the searched characters from all charaters list to searched characters list
  void _addCharactersToSearchedList(searchedWord) {
    _searchedCharacters = _allCharacters
        .where((character) =>
            character.character!.toLowerCase().startsWith(searchedWord) ||
            character.character!.startsWith(searchedWord))
        .toList();
  }

  //function for appbar actions
  List<Widget> _appBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _stopSearching();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear))
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              _startSearching();
            },
            icon: const Icon(Icons.search))
      ];
    }
  }

  void _stopSearching() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
    });
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  Widget appBarTitle() {
    return Text(
      'Harry Potter Movie Characters',
      style: TextStyle(fontSize: 20.0.sp),
    );
  }
}
