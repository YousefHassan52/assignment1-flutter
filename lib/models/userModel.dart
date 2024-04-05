class UserModel {
  String phone;
  String email;
  String personName;
  String companyName;
  String companyIndustry;
  String companyAddress;
  String companyLocation;
  String companySize;
  String password;

  UserModel({
    required this.phone,
    required this.email,
    required this.personName,
    required this.companyName,
    required this.companyIndustry,
    required this.companyAddress,
    required this.companyLocation,
    required this.companySize,
    required this.password,
   });

  factory UserModel.fromJson(Map<String, dynamic>json) {
    return UserModel(
        phone: json["phone"],
        email: json["email"],
        personName: json["personName"],
        companyName: json["companyName"],
        companyIndustry: json["companyIndustry"],
        companyAddress: json["companyAddress"],
        companyLocation: json["companyLocation"],
        companySize: json["companySize"],
        password: json["password"],);
  }

}