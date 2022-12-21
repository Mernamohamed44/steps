class UserModel{
  String?fName;
  String?lName;
  String?email;
  String?uId;
  UserModel(
      {
        this.fName,
        this.lName,
        this.email,
        this.uId,
      }
      );
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"] == null ? null : json["email"],
    fName: json["fName"] == null ? null : json["fName"],
    lName: json["lName"] == null ? null : json["lName"],
    uId: json["uId"] == null ? null : json["uId"],

  );
  Map<String,dynamic>toMap(){
    return {
      'fName':fName,
      'lName':lName,
      'email':email,
      'UId':uId,
    };
  }
}