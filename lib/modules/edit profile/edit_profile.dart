
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../shared/components/widgets/button.dart';
import '../../shared/components/widgets/text_form_field.dart';
import '../../shared/constants.dart';
import '../../shared/styles/colors.dart';
import '../google maps/google_maps.dart';
import '../register/cubit/cubit.dart';
import '../register/cubit/states.dart';

class EditProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit=AppCubit.get(context);
    cubit.personNameController.text=cubit.profile!.personName;
    cubit.emailController.text=cubit.profile!.email;
    cubit.companyNameController.text=cubit.profile!.companyName;
    cubit.companyAddressController.text=cubit.profile!.companyAddress;
    cubit.companySizeController.text=cubit.profile!.companySize;
    cubit.companyLocationController.text=cubit.profile!.companyLocation;
    cubit.passwordController.text=cubit.profile!.password;

    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is DataUpdateSuccessState)
            {
              cubit.getProfileData(phone: cubit.profile!.phone);
              cubit.getData(cubit.data);
            }
          if(state is DataUpdateLoadingState)
            {
              cubit.companyIndustry="";
            }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: mainColor,
              title: Text("Edit Your Profile Data"),

            ),
            body:SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          cubit.getProfileImage();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: mainColor),
                            borderRadius: BorderRadius.circular(10.0),

                          ),
                          child: Row(
                            children: [
                              Text("Upload Profile Picture"),
                              Spacer(),
                              Icon(Icons.image,color: mainColor,),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      defaultTextFormField(
                          controller: cubit.emailController,
                          validate: (value) {

                            if (value == null || value.isEmpty) {
                              return "field is required";
                            }
                            else if(value.isNotEmpty && EmailValidator.validate(value)==false )
                            {
                              return "Invalid Email Address";
                            }
                          },
                          text: "Email Address",
                          prefixIcon: Icons.alternate_email,
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(height: 10,),


                      defaultTextFormField(
                          controller: cubit.personNameController,
                          validate: (value) {
                            if (value == null || value.isEmpty)
                              return "field is required";
                          },
                          text: "Full Name",
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.text),
                      SizedBox(height: 10,),

                      defaultTextFormField(
                          controller: cubit.companyNameController,
                          validate: (value) {
                            if (value == null || value.isEmpty)
                              return "field is required";
                          },
                          text: "Company Name",
                          prefixIcon: Icons.home_repair_service,
                          keyboardType: TextInputType.text),
                      SizedBox(height: 10,),

                      defaultTextFormField(
                          controller: cubit.companyAddressController,
                          validate: (value) {
                            if (value == null || value.isEmpty)
                              return "field is required";
                          },
                          text: "Company Address",
                          prefixIcon: Icons.location_on_sharp,
                          keyboardType: TextInputType.text),
                      SizedBox(height: 10,),

                      InkWell(
                          onTap: (){
                            companyLocationOnMap=null;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Maps()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: mainColor,width: 1),
                              borderRadius: BorderRadius.circular(10),

                            ),
                            child: Row(children: [
                              Icon(Icons.my_location,color: mainColor,),
                              SizedBox(width: 12,),
                              Text("Location Of Company",style:GoogleFonts.nunitoSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black

                              ),),
                              Spacer(),
                              Icon(Icons.arrow_right,color: mainColor,),



                            ]),

                          )),

                      //-----------------------------------------------
                      SizedBox(height: 10,),

                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1,color: mainColor)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Choose Company Size",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                            Container(
                                height: 210,
                                child: ListView(
                                  children: [
                                    RadioListTile(

                                        title: Text("Micro"),
                                        value: 0,
                                        groupValue: cubit.selectedValue,
                                        onChanged: (value) {
                                          cubit.changeRadioValue(value!);
                                        }),
                                    RadioListTile(
                                        title: Text("Small"),
                                        value: 1,
                                        groupValue: cubit.selectedValue,
                                        onChanged: (value) {
                                          cubit.changeRadioValue(value!);
                                        }),
                                    RadioListTile(
                                        title: Text("Mini"),
                                        value: 2,
                                        groupValue: cubit.selectedValue,
                                        onChanged: (value) {
                                          cubit.changeRadioValue(value!);
                                        }),
                                    RadioListTile(
                                        title: Text("Large"),
                                        value: 3,
                                        groupValue: cubit.selectedValue,
                                        onChanged: (value) {
                                          cubit.changeRadioValue(value!);
                                        }),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),

                      defaultTextFormField(
                          controller: cubit.passwordController,
                          validate: (value) {
                            if(value==null || value.isEmpty)
                              return "field is required";
                            else if(value.length <8)
                              return "Min length 8";
                          },
                          text: "Password",
                          prefixIcon: Icons.password,
                          keyboardType: TextInputType.visiblePassword,
                      isPassword: true),
                      SizedBox(height: 10,),


                      MultiSelectDialogField(
                        title: const Text("Select Industries",),
                        buttonText: const Text("Company Industries"),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: mainColor),

                        ),
                        selectedColor: mainColor,
                        selectedItemsTextStyle: const TextStyle(color: Colors.white),

                        items: cubit.type,
                        listType: MultiSelectListType.CHIP,
                        buttonIcon: Icon(Icons.arrow_drop_down,color: mainColor,),

                        onConfirm: (values) {
                          cubit.selectedTypes=values;
                          print(cubit.selectedTypes.toString());
                        },
                      ),
                      SizedBox(height: 15,),

                      defaultButton(
                          function: () {
                            if (cubit.formKey.currentState!.validate() ) {
                              cubit.updateUser(
                                phone: cubit.profile!.phone,
                                email: cubit.emailController.text,
                                personName: cubit.personNameController.text,
                                companyName: cubit.companyNameController.text,
                                companyIndustry:cubit.compnayIndustries(),
                                companyAddress: cubit.companyAddressController.text,
                                companyLocation:companyLocationOnMap.toString()!="null"?companyLocationOnMap.toString():cubit.profile!.companyLocation,
                                companySize: cubit.companySize[cubit.selectedValue],
                                password: cubit.passwordController.text,
                              );
                            }
                          },
                          text: "U P D A T E"),
                    ],
                  ),
                ),
              ),
            ) ,
          );

        },
    );
  }
}
