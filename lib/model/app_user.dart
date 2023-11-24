class AppUser {
  String? uid;
  String? type;
  String? name;
  String? email;
  String? phoneNumber;
  String? lastName;
 
  AppUser(
      {this.uid,
      this.type,
      this.name,
      this.email,
     this.lastName});

  AppUser.myFromJsonFuntion(Map<String, dynamic> jsonParameter) {
    try {
      uid = jsonParameter['uid'];
      type = jsonParameter['type'];
      name = jsonParameter['name'];
      email = jsonParameter['email'];
      lastName = jsonParameter['lastName'];
      
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Map<String, dynamic> myToJson() {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['uid'] = uid;

      data['type'] = type;
      data['name'] = name;
      data['email'] = email;
    
      data['lastName'] = lastName;
      
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
