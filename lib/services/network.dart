import 'dart:convert';
import 'package:reddit_clone/models/posts/reddit_message_box.dart';
import 'package:http/http.dart' as http;
import 'package:reddit_clone/models/posts/reddit_response.dart';
import 'package:reddit_clone/utils/constants.dart';

class Network {
  Future<List<RedditMessageBox>?> getPosts() async {
    try {
      final uri = Uri.https(
          Constants.baseUrl, '/r/flutterdev/top.json', {'count': '20'});
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var redditResponse = RedditResponse.fromJson(jsonDecode(response.body));
        return redditResponse.data?.children;
      } else {
        print("Something went wrong while decoding Json!");
        return null;
      }
    } on Exception catch (e) {
      print("Something went wrong while fetching posts: $e ");
      return null;
    }
  }
}
