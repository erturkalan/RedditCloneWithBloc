import 'package:reddit_clone/models/posts/reddit_message_box.dart';

class RedditPostResponse {
  List<RedditMessageBox>? children;

  RedditPostResponse({this.children});

  RedditPostResponse.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = <RedditMessageBox>[];
      json['children'].forEach((v) {
        children?.add(RedditMessageBox.fromJson(v));
      });
    }
  }
}
