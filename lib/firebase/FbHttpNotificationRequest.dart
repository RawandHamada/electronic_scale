import 'dart:convert';
import 'package:http/http.dart' as http;

class FbHttpNotificationRequest {
  // List<String> listName = [
  //   "dDfXBJzNQXOkzOSi6RKgOe:APA91bHq6s1qMcqpwTF6itdksh15bzRauL6JosN5QxVc-ECdYuwCHp6NJD1G99EVN76OVIqph0P9w3hRy10yuLr2AoEJHO47Fb1VTdNaAk5ix_xZrSBllJjITyEqR9AzHuWiOJ7kn_MA",
  //   "dDfXBJzNQXOkzOSi6RKgOe:APA91bHq6s1qMcqpwTF6itdksh15bzRauL6JosN5QxVc-ECdYuwCHp6NJD1G99EVN76OVIqph0P9w3hRy10yuLr2AoEJHO47Fb1VTdNaAk5ix_xZrSBllJjITyEqR9AzHuWiOJ7kn_MA"
  // ];

  void sendNotification(String title , String body , List<dynamic> listName) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'key=AAAA4hl5XKU:APA91bEp85qIJCaiXXgVyzc-_HnLPGxQ_HnYgvUbs5NG76hu6SzuA7Ty4i1qZ2FCVW0sqvbD5Whh1RRyKheoIm47qI923ePke1z3ToBwW7co-thfkIVXE-iBA18Be4v_Z3r6pZZUEg7c'
    };
    var request =
    http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "notification": {
        "title": title,
        "body": body,
        "click_action": "OPEN_ACTIVITY_1"
      },
      "data": {"keyname": "any value "},
      "registration_ids": listName
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}