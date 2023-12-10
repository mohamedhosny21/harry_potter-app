import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_bloc/constants/constants.dart';
import 'package:test_bloc/presentation_layer/widgets/divider_widget.dart';

import '../../data_layer/model/characters_model.dart';

class CharacterDetails extends StatelessWidget {
  final CharactersModel charactersModel;
  const CharacterDetails({
    Key? key,
    required this.charactersModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          buildSLiverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin:
                  EdgeInsetsDirectional.fromSTEB(8.0.w, 20.0.h, 8.0.w, 0.0.h),
              padding: EdgeInsetsDirectional.all(15.0.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCharactersInfo(
                      "Name : ", charactersModel.character.toString()),
                  buildDivider(275.0.w),
                  buildCharactersInfo("Actor/Actress : ",
                      charactersModel.interpretedBy.toString()),
                  buildDivider(215.0.w),
                  buildCharactersInfo("Hogwarts Student : ",
                      charactersModel.hogwartsStudent == true ? 'Yes' : 'No'),
                  buildDivider(190.0.w),
                  buildCharactersInfo("Hogwarts House : ",
                      charactersModel.hogwartsHouse.toString()),
                  buildDivider(200.0.w),
                  charactersModel.child!.isEmpty
                      ? Container()
                      : buildCharactersInfo("Children : ",
                          charactersModel.child!.join('/').toString()),
                  charactersModel.child!.isEmpty
                      ? Container()
                      : buildDivider(250.0.w),
                  SizedBox(
                    height: mediaQueryHeight(context) / 2,
                  )
                ],
              ),
            )
          ])),
        ],
      ),
    );
  }

  Widget buildCharactersInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0.sp),
        ),
        TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.white,
            ))
      ]),
    );
  }

  Widget buildSLiverAppBar() {
    //SLiverAppBar : we design the image and title on the image
    return SliverAppBar(
      expandedHeight: 350.0.h,
      pinned: true,
      backgroundColor: Colors.amber,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
            tag: '${charactersModel.id}',
            child: Image(
              image: NetworkImage('${charactersModel.image}'),
              fit: BoxFit.fill,
            )),
        title: Text('${charactersModel.nickname}'),
        centerTitle: true,
      ),
    );
  }
}
