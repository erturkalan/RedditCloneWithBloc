part of 'posts_bloc.dart';

abstract class PostsEvent {
  const PostsEvent();
}

class GetPostsEvent extends PostsEvent {}

class PostClickedEvent extends PostsEvent {
  final RedditPost clickedPost;
  PostClickedEvent({required this.clickedPost});
}
