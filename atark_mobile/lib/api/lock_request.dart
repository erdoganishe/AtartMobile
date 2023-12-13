import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken') ?? '';
}

Future<String> getUId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('uId') ?? '';
}

Future<void> makeAuthenticatedRequest(String ur) async {
  final accessToken = await getAccessToken();

  if (accessToken.isNotEmpty) {
    try {
      // Make sure to replace 'your-authenticated-endpoint' with the actual URL of your authenticated endpoint
      final url = Uri.parse('http://192.168.0.108:3000$ur');

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        // Request successful, handle the response as desired
        final responseData = jsonDecode(response.body);
        // Do something with the response data
      } else {
        // Handle error response
        print(
            'Authenticated request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle any exceptions that occurred during the request
      print('Error during authenticated request: $error');
    }
  } else {
    // Handle the case when the access token is not available
    print('Access token not available');
  }
}

Future<void> putLock(String lId, bool b) async {
  final accessToken = await getAccessToken();

  if (accessToken.isNotEmpty) {
    try {
      // Make sure to replace 'your-authenticated-endpoint' with the actual URL of your authenticated endpoint
      final url = Uri.parse('http://192.168.0.108:3000/lock-mob');
      final response = await http.put(url,
          headers: {'Authorization': 'Bearer $accessToken'},
          body: {"isAbleToChange": b.toString(), "id": lId});
      if (response.statusCode == 200) {
        // Request successful, handle the response as desired
        final responseData = jsonDecode(response.body);
        // Do something with the response data
      } else {
        // Handle error response
        print(
            'Authenticated request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle any exceptions that occurred during the request
      print('Error during authenticated request: $error');
    }
  } else {
    // Handle the case when the access token is not available
    print('Access token not available');
  }
}

class LockDetails {
  String? id;
  String? uId;
  String? name;
  String? adress;
  bool isAbleToChange;
  List<dynamic>? keys;
  LockDetails(
      {required this.id,
      required this.uId,
      required this.name,
      required this.adress,
      required this.isAbleToChange
      // required this.keys
      });
  // factory LockDetails.fromJson(Map<String, dynamic> json) {
  //   return LockDetails(
  //     id: json['id'],
  //     uId: json['uId'],
  //     name: json['name'],
  //     adress: json['adress'],
  //     // keys : json['keys']
  //   );
  // }
  LockDetails.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        uId = json['uId'],
        name = json['name'],
        adress = json['adress'],
        isAbleToChange = json['isAbleToChange'] as bool
  //keys :json['keys']
  ;
}

Future<List<LockDetails>> getLockDetailsByUId() async {
  print('start');
  final accessToken = await getAccessToken();
  final uId = await getUId();
  List<LockDetails> a = List.empty();

  if (accessToken.isNotEmpty) {
    try {
      // Make sure to replace 'your-authenticated-endpoint' with the actual URL of your authenticated endpoint
      final url = Uri.parse('http://192.168.0.108:3000/lock-mob-by-uid/$uId');

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (response.statusCode == 200) {
        // Request successful, handle the response as desired
        //final responseData = jsonDecode(response.body);
        List<dynamic> l = json.decode(response.body);
        List<LockDetails> ld = [];
        for (var item in l) {
          //print(item['keys']);
          LockDetails tmp = LockDetails.fromJSON(item);
          tmp.keys = item['keys'];
          ld.add(tmp);
        }
        //print(ld.toString());
        // for (var item in posts) {
        //   await getUserDetails(item.user1 ?? "")
        //       .then((value) => item.username1 = value.username);
        //   print('u2: ${item.user2}');
        //   await getUserDetails(item.user2 ?? "").then((value) {
        //     print('value u2: ${value}');
        //     item.username2 = value.username;
        //   });
        //   print(item.username2);
        // }
        return ld;
      } else {
        // Handle error response
        print(
            'Authenticated request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return a;
      }
    } catch (error) {
      // Handle any exceptions that occurred during the request
      print('Error during authenticated request: $error');
      return a;
    }
  } else {
    // Handle the case when the access token is not available
    print('Access token not available');
    return a;
  }
}

// class UserDetails {
//   String? username;
//   String? rena;
//   UserDetails({this.username, this.rena});
//   UserDetails.fromJSON(Map<String, dynamic> json)
//       : username = json['username'],
//         rena = json['rena'];
// }

// Future<UserDetails> getUserDetails(String uid) async {
//   final accessToken = await getAccessToken();
//   UserDetails a = UserDetails(username: 'Player have not connected', rena: 'a');

//   if (accessToken.isNotEmpty) {
//     try {
//       // Make sure to replace 'your-authenticated-endpoint' with the actual URL of your authenticated endpoint
//       final url =
//           Uri.parse('https://chess-arena-3.onrender.com/game-mobile/$uid');

//       final response = await http.get(
//         url,
//         //headers: {'Authorization': 'Bearer $accessToken'},
//       );

//       if (response.statusCode == 200) {
//         // Request successful, handle the response as desired
//         final responseData = jsonDecode(response.body);
//         Map<String, dynamic> l = json.decode(response.body);
//         print('l: $l');
//         UserDetails post = UserDetails.fromJSON(l);
//         // print(posts);
//         print('post: ${post.username}');
//         return post;
//         // Do something with the response data
//       } else {
//         // Handle error response
//         print(
//             'Authenticated request failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         return a;
//       }
//     } catch (error) {
//       // Handle any exceptions that occurred during the request
//       print('Error during authenticated request: $error');
//       return a;
//     }
//   } else {
//     // Handle the case when the access token is not available
//     print('Access token not available');
//     return a;
//   }
// }
