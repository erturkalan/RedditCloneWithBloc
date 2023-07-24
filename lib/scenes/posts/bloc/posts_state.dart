part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

abstract class PostsActionState extends PostsState {}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedSuccessState extends PostsState {
  final List<RedditMessageBox> posts;
  PostsLoadedSuccessState({required this.posts});
}

class PostsLoadedErrorState extends PostsState {}

class PostsNavigateToSiteState extends PostsActionState {
  final RedditPost clickedPost;

  PostsNavigateToSiteState({required this.clickedPost});
}
