
import 'package:assignment_two/modules/login/cubit/cubit.dart';
import 'package:assignment_two/shared/bloc_observer.dart';
import 'package:assignment_two/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/home/home_screen.dart';
import 'modules/register/cubit/cubit.dart';
import 'modules/register/signup.dart';

void main() {
  print(companyLocationOnMap??"null ya sadekiiii");

  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()..createDatabase()),
        BlocProvider(create: (context)=>LoginCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
