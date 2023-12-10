import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_bloc/data_layer/model/characters_model.dart';

class CharactersWidget extends StatelessWidget {
  const CharactersWidget({Key? key, required this.charactersModel})
      : super(key: key);
  final CharactersModel charactersModel;

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/characters_details_page',
            arguments: charactersModel);
      },
      child: Hero(
        tag: '${charactersModel.id}',
        child: GridTile(
            child: charactersModel.image!.isNotEmpty
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loadinganim.gif',
                    image: '${charactersModel.image}',
                    fit: BoxFit.fill,
                  )
                : Image.asset('assets/images/x.png'),
            footer: GridTileBar(
              backgroundColor: Colors.black45,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    charactersModel.character.toString(),
                    style: TextStyle(
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
