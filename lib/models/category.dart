class Category{
  late String nameCategory;

  Category();
  Category.fromMap(Map<String, dynamic> map){
    nameCategory = map['nameCategory'];


  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String,dynamic>();
    map['nameCategory'] = nameCategory;
    return map;
  }

}