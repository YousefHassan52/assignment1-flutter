class CompanyModel {
  int companyId;
  String companyName;
  String serviceTitle;
  String serviceDescription;

  CompanyModel({


    required this.companyId,
    required this.companyName,
    required this.serviceTitle,
    required this.serviceDescription,

  });

  factory CompanyModel.fromJson(Map<String, dynamic>json) {
    return CompanyModel(
      companyId: json["companyId"],
      companyName: json["companyName"],
      serviceTitle: json["serviceTitle"],
      serviceDescription: json["serviceDescription"],
     );
  }

}