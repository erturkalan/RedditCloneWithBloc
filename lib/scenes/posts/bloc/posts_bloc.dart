import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit_clone/models/posts/reddit_message_box.dart';
import 'package:reddit_clone/models/posts/reddit_post.dart';
import 'package:reddit_clone/services/network.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<GetPostsEvent>(getPostsEvent);

    on<PostClickedEvent>(postClickedEvent);
  }

  FutureOr<void> getPostsEvent(
      GetPostsEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());
    final networkService = Network();
    var response = await networkService.getPosts();
    if (response != null && response.isNotEmpty) {
      emit(PostsLoadedSuccessState(posts: response));
    } else {
      emit(PostsLoadedErrorState());
    }
  }

  FutureOr<void> postClickedEvent(
      PostClickedEvent event, Emitter<PostsState> emit) {
    emit(PostsNavigateToSiteState(clickedPost: event.clickedPost));
  }
}
