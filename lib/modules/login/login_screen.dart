
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components/widgets/button.dart';
import '../../shared/components/widgets/text_form_field.dart';
import '../../shared/components/widgets/toast.dart';
import '../../shared/styles/colors.dart';
import '../profile/profile.dart';
import '../register/cubit/cubit.dart';
import '../register/signup.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=LoginCubit.get(context);

    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if(state is FailLoginState)
          {
            warningText(context: context, text: "Wrong Phone Number Or Password", color: Colors.red);
          }
        if(state is SuccessLoginState)
        {
          warningText(context: context, text: "Success Login", color: Colors.green);
          AppCubit.get(context).getProfileData(phone: state.phone);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ProfileScreen(phone:state.phone )),(route) => false,);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: mainColor,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login Now",style: GoogleFonts.nunitoSans(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: mainColor

                    ),),
                    SizedBox(height: 25,),
                    defaultTextFormField(
                        controller: cubit.phoneController,
                        validate: (value){
                          if(value ==null ||value.isEmpty)
                            {
                              return "Phone is Required";
                            }
                        },
                        text: "Phone Number",
                        prefixIcon: Icons.phone,
                        keyboardType: TextInputType.phone),
                    SizedBox(height: 10,),

                    defaultTextFormField(
                        controller: cubit.passwordController,
                        validate: (value){
                          if(value ==null ||value.isEmpty)
                          {
                            return "Password is Required";
                          }
                        },
                        text: "Password",
                        prefixIcon: Icons.password,
                        keyboardType: TextInputType.visiblePassword,
                      isPassword: true,

                    ),
                    SizedBox(height: 20,),
                    defaultButton(function: (){
                      if(cubit.formKey.currentState!.validate())
                        {
                          cubit.login(phone: cubit.phoneController.text, password: cubit.passwordController.text);
                        }
                    }, text: "L O G I N"),
                    Row(children: [
                      Text("Don't have an account ?"),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                      }, child: Text("Register")),
                    ],),

                    if(state is LoadingLoginState)
                      CircularProgressIndicator(),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
