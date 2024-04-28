import 'package:blog_app/blocs/articles/article_bloc.dart';
import 'package:blog_app/blocs/articles/article_event.dart';
import 'package:blog_app/constants/constants.dart';
import 'package:blog_app/models/blog.dart';
import 'package:blog_app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogDetails extends StatefulWidget {
  final Blog blog;

  const BlogDetails({
    super.key,
    required this.blog,
  });

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: ScreenUtil.getHeight(context) * 0.6,
            width: ScreenUtil.getWidth(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.blog.thumbnail!,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.blog.title!,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            height: ScreenUtil.getHeight(context) * 0.04,
                            width: ScreenUtil.getHeight(context) * 0.04,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.blog.author!,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_document),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogEditOrCreateScreen(
                            blog: widget.blog,
                          ),
                        ));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context
                        .read<ArticleBloc>()
                        .add(DeleteArticles(widget.blog));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              height: ScreenUtil.getHeight(context) * 0.55,
              width: ScreenUtil.getWidth(context),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                child: Text(
                  widget.blog.content!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
