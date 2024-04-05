

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/components/widgets/button.dart';
import '../login/login_screen.dart';
import '../register/cubit/cubit.dart';
import '../register/cubit/states.dart';
import '../register/signup.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(

          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(child: SvgPicture.asset("assets/images/Hello-rafiki.svg")),
                defaultButton(function: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                }, text: "Login"),
                SizedBox(height: 15,),
                defaultButton(function: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));

                }, text: "Register"),
                SizedBox(height: 100,),
              ],
            ),
          ),
        );
      },
    );
  }
}
