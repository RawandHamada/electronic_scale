class Branch{
 late String nameBranch;

 Branch();
 Branch.fromMap(Map<String, dynamic> map){
   nameBranch = map['nameBranch'];


 }

 Map<String, dynamic> toMap() {
   Map<String, dynamic> map = Map<String,dynamic>();
   map['nameBranch'] = nameBranch;
   return map;
 }

}