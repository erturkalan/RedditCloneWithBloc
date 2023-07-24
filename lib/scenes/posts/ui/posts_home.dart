import 'package:flutter/material.dart';
import 'package:reddit_clone/models/posts/reddit_message_box.dart';
import 'package:reddit_clone/scenes/posts/bloc/posts_bloc.dart';
import 'package:reddit_clone/scenes/posts/ui/post_box_widget.dart';
import 'package:reddit_clone/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PostsHome extends StatefulWidget {
  const PostsHome({Key? key}) : super(key: key);

  @override
  State<PostsHome> createState() => _PostsHomeState();
}

class _PostsHomeState extends State<PostsHome> {
  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future refresh() async {
    postsBloc.add(GetPostsEvent());
  }

  final PostsBloc postsBloc = PostsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      bloc: postsBloc,
      listenWhen: (previous, current) => current is PostsActionState,
      buildWhen: (previous, current) => current is! PostsActionState,
      listener: (context, state) {
        if (state is PostsNavigateToSiteState) {
          if (state.clickedPost.permalink != null) {
            launchUrlString(
                "https://${Constants.baseUrl}${state.clickedPost.permalink!}");
          }
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case PostsLoadingState:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.deepOrange,
                title: const Text(Constants.appName),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case PostsLoadedSuccessState:
            final successState = state as PostsLoadedSuccessState;
            var posts = <RedditMessageBox>[];
            if (successState.posts.isNotEmpty) {
              for (var element in successState.posts) {
                if (element.data != null) {
                  posts.add(element);
                }
              }
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.deepOrange,
                title: const Text(Constants.appName),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: RefreshIndicator(
                        onRefresh: refresh,
                        child: ListView.builder(
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              return PostBoxWidget(
                                post: posts[index].data!,
                                postsBloc: postsBloc,
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            );
          case PostsLoadedErrorState:
            return const Scaffold(
              body: Center(
                child: Text(Constants.errorMessage),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
