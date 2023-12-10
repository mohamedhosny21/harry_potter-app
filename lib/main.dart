import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_bloc/app_router.dart';
import 'package:test_bloc/business_logic_layer/cubit/characters_cubit.dart';
import 'package:test_bloc/business_logic_layer/cubit/internet_cubit.dart';
import 'package:test_bloc/data_layer/repository/characters_repository.dart';
import 'package:test_bloc/data_layer/webservices/characters_webservices.dart';

void main() {
  runApp(HarryPotterApp(
    appRouter: AppRouter(),
  ));
}

class HarryPotterApp extends StatelessWidget {
  const HarryPotterApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CharactersCubit(CharactersRepository(CharactersWebServices())),
        ),
        BlocProvider(
          create: (context) => InternetCubit(connectivity: Connectivity()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
          );
        },
      ),
    );
  }
}
