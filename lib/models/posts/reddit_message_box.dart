import 'package:reddit_clone/models/posts/reddit_post.dart';

class RedditMessageBox {
  RedditPost? data;

  RedditMessageBox({this.data});

  RedditMessageBox.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? RedditPost.fromJson(json['data']) : null);
  }
}
