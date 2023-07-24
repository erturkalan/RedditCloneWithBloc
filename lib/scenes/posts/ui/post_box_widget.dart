import 'package:flutter/material.dart';
import 'package:reddit_clone/models/posts/reddit_post.dart';
import 'package:reddit_clone/scenes/posts/bloc/posts_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostBoxWidget extends StatelessWidget {
  final RedditPost post;
  final PostsBloc postsBloc;
  const PostBoxWidget({Key? key, required this.post, required this.postsBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: InkWell(
        onTap: () => postsBloc.add(PostClickedEvent(clickedPost: post)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 5), // changes position of shadow
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  post.author != null ? "Posted by ${post.author!}" : "",
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  post.title != null ? post.title! : "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                (post.thumbnail != null && post.thumbnail!.startsWith("https:"))
                    ? Flexible(
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 4 / 5,
                                child: CachedNetworkImage(
                                  fit: BoxFit.fitWidth,
                                  imageUrl: post.thumbnail!,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                (post.selfText != null && post.selfText!.isNotEmpty)
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 100,
                              child: Text(
                                post.selfText!,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 11),
                              ))
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
