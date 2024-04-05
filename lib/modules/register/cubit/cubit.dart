import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/companyModel.dart';
import '../../../models/userModel.dart';
import '../../../shared/constants.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<String> companySize = ["Micro", "Small", "Mini", "Large"];
  String currentOption = "Micro";
  int selectedValue = 0;

  void changeRadioValue(int value) {
    selectedValue = value;
    print("$selectedValue");
    emit(ChangedradioState());
  }


  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var personNameController = TextEditingController();
  var companyNameController = TextEditingController();
  var companyAddressController = TextEditingController();
  var companyLocationController = TextEditingController();
  var companySizeController = TextEditingController();
  var passwordController = TextEditingController();
  var repeatedPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  late Database data;
  UserModel? profile;

  List<Map<String,dynamic>> companiesTable=[
    {
      "companyId":1,
      "companyName":"Google",
      "serviceTitle":"software development",
      "serviceDescription":"Google began as an online search firm, but it now offers more than 50 Internet services and products, from e-mail and online document creation to software for mobile phones and tablet computers",
    },
    {
      "companyId":2,
      "companyName":"ferrari",
      "serviceTitle":"cars industry",
      "serviceDescription":"provide their customers with sport cars",
    },
    {
      "companyId":3,
      "companyName":"apple",
      "serviceTitle":"mobile industry",
      "serviceDescription":"provide to the market phones with high quality in security ",
    },
    {
      "companyId":4,
      "companyName":"orange",
      "serviceTitle":"network industry",
      "serviceDescription":"make the world more closer",
    },

  ];
  /*companyId int PRIMARY KEY,
  companyName TEXT,
  serviceTitle TEXT,
  serviceDescription Text*/
  void createDatabase() {
    openDatabase(
      "assignment_app",
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                "CREATE TABLE users(phone TEXT PRIMARY KEY,email TEXT,companyName TEXT,personName TEXT,companyIndustry TEXT,companyAddress TEXT,companyLocation TEXT,companySize TEXT,password TEXT)")
            .then((value) {

          print("table created");
        }).catchError((error) {
          print("error while creating table tasks: ${error.toString()}");
        });

        database.execute("CREATE TABLE services(companyId int PRIMARY KEY,companyName TEXT,serviceTitle TEXT,serviceDescription Text)")
            .then((value) {
          companiesTable.forEach((map) {
            database.rawInsert('INSERT INTO services(companyId,companyName,serviceTitle,serviceDescription) VALUES ("${map["companyId"]}","${map["companyName"]}"),"${map["serviceTitle"]}","${map["serviceDescription"]}"').then((value) {
              emit(InsertedToServicesTableSuccessState());
            }).catchError((error){
              print(error.toString());
              emit(InsertedToServicesTableErrorState());

            });
          });




          emit(ServiceTableCreatedSuccessState());
        }).catchError((error){
          emit(ServiceTableCreatedErrorState());
        });
      },
      onOpen: (database) {
        print("database opened");
        getData(database);
        getServicesData(database);
      },
    ).then((value) {
      // el value heya el database
      data = value;
      emit(
          CreateDatabaseTodoState()); // ha emit lma ye5las 34an kda badal ma 2a2ol data=await openDatabase 2olt data = vale fa heya heya
    });

  }

  void getData(Database database) {
    users = [];
    database.rawQuery('SELECT * FROM users').then((value) {
      for (var element in value) {
        users.add(UserModel.fromJson(element));
        print(element);
      }

      emit(GetFromDatabaseTodoState());
    });
  }

  List<CompanyModel> servicesFromDataBase=[];
  void getServicesData(Database database) {
    servicesFromDataBase = [];
    database.rawQuery('SELECT * FROM services').then((value) {
      for (var element in value) {
        servicesFromDataBase.add(CompanyModel.fromJson(element));
        print(element);
      }

      emit(GetFromDatabaseTodoState());
    });
  }

  Future insertToDatabase({
    required String phone,
    required String email,
    required String personName,
    required String companyName,
    required String companyIndustry,
    required String companyAddress,
    required String companyLocation,
    required String companySize,
    required String password,
    required String repeatedPassword,
  }) async {
    // first check that location on map !=null
    if (companyLocationOnMap != null) {
    // second check that the entered data "email & phone" is unique and not repeatable
    if (checkIfTheUserIsUnique(phone: phone, email: email) == true) {
      await data.transaction((txn) {
        return txn
            .rawInsert(
                'INSERT INTO users(phone,email,personName,companyName,companyIndustry,companyAddress,companyLocation,companySize,password) VALUES ("$phone","$email","$personName","$companyName","$companyIndustry","$companyAddress","$companyLocation","$companySize","$password")')
            .then((value) {
          // print("record of id $value is added");
          emit(InsertIntoDatabaseTodoSuccessState());
          getData(data);
        }).catchError((error) {
          emit(ErrorInsertState());
          // print("error while inserting data ${error.toString()}");
        });
      });
    } else {
      emit(RepeatableUserData());
    }
    }
    else {
      emit(NullCompanyLocationState());
    }
  }

  bool checkIfTheUserIsUnique({
    required String email,
    required String phone,
  }) {
    bool permissionToEnter = true;

    users.forEach((element) {
      if (email == element.email || phone == element.phone) {
        permissionToEnter = false;
      }
    });
    return permissionToEnter;
  }

  void getProfileData({required String phone}) async {
    emit(GetProfileDataLoadingState());
    data.query(
      'users',
      where: 'phone = ?',
      whereArgs: [phone],
    ).then((value) {
      profile = UserModel.fromJson(value.first);
      emit(GetProfileDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileDataErrorState());
    });
  }

  List<MultiSelectItem> type = [
    MultiSelectItem("Software development", "Software development"),
    MultiSelectItem("Civil Engineering", "Civil Engineering"),
    MultiSelectItem("Graphic Designs", "Graphic Designs"),
  ];
  List selectedTypes = [];

  String companyIndustry = "";

  String compnayIndustries() {
    selectedTypes.forEach((element) {
      companyIndustry += " " + element.toString();
    });
    return companyIndustry;
  }

  void updateUser({
  required  String phone,
  required  String email,
  required  String personName,
  required  String companyName,
  required  String companyIndustry,
  required  String companyAddress,
  required  String companyLocation,
  required  String companySize,
  required  String password,
  }) {
    emit(DataUpdateLoadingState());
    data.update(
          'users',
          {
            'email': email,
            'personName': personName,
            'companyName': companyName,
            'companyIndustry': companyIndustry,
            'companyAddress': companyAddress,
            'companyLocation': companyLocation,
            'companySize': companySize,
            'password': password,
          },
          where: 'phone = ?',
          whereArgs: [phone],
        )
        .then((value) {
          emit(DataUpdateSuccessState());
    })
        .catchError((error) {
      emit(DataUpdateErrorState());

    });
  }


  var picker = ImagePicker();

  File? profileImage;

  //This Method From Internet
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ImagePickerSuccessSocialState());
    } else {
      print('No image selected');
      emit(ImagePickerErrorSocialState());
    }
  }
}
