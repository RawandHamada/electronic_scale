class Users {
 late String name;
 late String email;
  late String uid;
  late String password;
  late String nameBranch;
  //late String isActive;

 Users({required this.name, required this.email,required String this.uid,required String this.password,required String this.nameBranch});
 Users.fromMap(Map<String, dynamic> map){
  // isActive = map['isActive'];
   uid = map['uid'];
   name = map['name'];
   email = map['email'];
   password = map['password'];
   nameBranch = map['nameBranch'];
 }

 Map<String, dynamic> toMap() {
   Map<String, dynamic> map = Map<String,dynamic>();
  // map['isActive'] = isActive;
   map['name'] = name;
   map['uid'] = uid;
   map['email'] = email;
   map['password'] = password;
   map['nameBranch'] = nameBranch;
   return map;
 }

}
