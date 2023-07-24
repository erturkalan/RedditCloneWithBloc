class RedditPost {
  String? selfText;
  String? title;
  String? permalink;
  String? thumbnail;
  String? author;

  RedditPost(
      {this.selfText, this.title, this.permalink, this.thumbnail, this.author});

  RedditPost.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    selfText = json['selftext'];
    title = json['title'];
    permalink = json['permalink'];
    thumbnail = json['thumbnail'];
    author = json['author'];
  }
}
