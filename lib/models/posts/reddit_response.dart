import 'package:reddit_clone/models/posts/reddit_post_response.dart';

class RedditResponse {
  RedditPostResponse? data;

  RedditResponse({required this.data});

  RedditResponse.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? RedditPostResponse.fromJson(json['data']) : null;
  }
}
