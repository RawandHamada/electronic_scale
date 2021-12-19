class Scale{
  late String path;
  late String nameCustomer;
  late String title;
  late String weight;
  late String date;
  late String time;
  //late String nameBranch;
  late String nameColor;
  late String nameCategory;
  late String pathImage;
  late String uid;


  Scale();
  Scale.fromMap(Map<String,dynamic> map){
    uid = map['uid'];
    title = map['title'];
    weight = map['weight'];
    nameCustomer = map['nameCustomer'];
    date = map['date'];
    time = map['time'];
    //nameBranch = map['nameBranch'];
    nameColor = map['nameColor'];
    nameCategory = map['nameCategory'];
    pathImage = map['pathImage'];


  }
  Map<String,dynamic>  toMap(){
    Map<String,dynamic> map = Map<String,dynamic>();
    map['uid'] = uid;
    map['title'] = title;
    map['weight'] = weight;
    map['nameCustomer'] = nameCustomer;
    map['date'] = date;
    map['time'] = time;
    map['nameColor'] = nameColor;
    //map['nameBranch'] = nameBranch;
    map['nameCategory'] = nameCategory;
    map['pathImage'] = pathImage;

    return map;
  }

}