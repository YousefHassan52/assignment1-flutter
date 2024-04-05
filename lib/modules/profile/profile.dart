
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/styles/colors.dart';
import '../edit profile/edit_profile.dart';
import '../register/cubit/cubit.dart';
import '../register/cubit/states.dart';

class ProfileScreen extends StatelessWidget {

  String phone;

  ProfileScreen({required this.phone});

  @override
  Widget build(BuildContext context) {
    var cubit=AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              leading: IconButton(icon: Icon(Icons.edit),onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
              },),
            ),
            body: cubit.profile!=null? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Container(
                     padding: EdgeInsets.all(8.0),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: mainColor
                     ),
                     child: Row(
                       children: [
                         cubit.profileImage!=null?
                           CircleAvatar(radius: 50,backgroundImage: FileImage(cubit.profileImage!,),):CircleAvatar( radius:50,backgroundImage:AssetImage("assets/images/0.png"),),
                          SizedBox(width: 15,),
                         Expanded(
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${cubit.profile!.personName}",maxLines: 1,style: GoogleFonts.nunitoSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white

                                ),),
                                SizedBox(height: 15,),
                                Text("${cubit.profile!.phone}",style: GoogleFonts.nunitoSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white

                                ),),
                              ],
                            ),
                         ),
                       ],
                     ),
                   ),
                    InfoComponent(field:"Email" ,fieldValue:cubit.profile!.email ),
                    InfoComponent(field:"Company Name" ,fieldValue:cubit.profile!.companyName ),
                    InfoComponent(field:"Company Address" ,fieldValue:cubit.profile!.companyAddress ),
                    InfoComponent(field:"Company Location" ,fieldValue:cubit.profile!.companyLocation ),
                    InfoComponent(field:"Company Size" ,fieldValue:cubit.profile!.companySize ),
                    InfoComponent(field:"Company Industries" ,fieldValue:cubit.profile!.companyIndustry ),
                    InfoComponent(field:"Company Location" ,fieldValue:cubit.profile!.companyLocation ),


                  ],
                ),
              ),
            ):Center(child: CircularProgressIndicator(),),
          );
          },
        listener: (context,state){}
    );
  }
}

class InfoComponent extends StatelessWidget {
  String field;
  String fieldValue;


  InfoComponent({required this.field,required this.fieldValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field,style: GoogleFonts.nunitoSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],

          ),),
          SizedBox(height: 10,),
          Text(fieldValue,style: GoogleFonts.nunitoSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black

          ),),
          SizedBox(height: 5,),
          Container(width: double.infinity,height: 1,color: Colors.grey[400],),


        ],
      ),
    );
  }
}
