class Branch{
 late String nameColor;

 Branch();
 Branch.fromMap(Map<String, dynamic> map){
   nameColor = map['nameColor'];


 }

 Map<String, dynamic> toMap() {
   Map<String, dynamic> map = Map<String,dynamic>();
   map['nameColor'] = nameColor;
   return map;
 }

}