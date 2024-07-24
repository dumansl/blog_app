import 'package:blog_app/blocs/articles/article_bloc.dart';
import 'package:blog_app/blocs/articles/article_event.dart';
import 'package:blog_app/blocs/articles/article_state.dart';
import 'package:blog_app/constants/screen_util.dart';
import 'package:blog_app/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(
      listener: (context, state) {
        if (state is ArticleAdded || state is ArticleUpdated) {
          context.read<ArticleBloc>().add(FetchArticles());
        }
      },
      builder: (context, state) {
        if (state is ArticlesNotLoaded) {
          context.read<ArticleBloc>().add(FetchArticles());
          return Center(
            child: Text(
              "Yazıların yükleme işlemi başlamadı...",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
        if (state is ArticlesLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        if (state is ArticlesLoadFail) {
          return Center(
            child: Text(
              "Blogların yüklenmesinde hata oluştu",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
        if (state is ArticlesLoaded) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hoşgeldiniz",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF7D7D7D),
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Son Eklenenler',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil.getHeight(context) * 0.35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      if (index >= state.blogs.length || index >= 5) {
                        return const SizedBox();
                      }
                      final reversedIndex = state.blogs.length - 1 - index;
                      return CustomCard(
                        isLastAdded: true,
                        blog: state.blogs[reversedIndex],
                      );
                    },
                    itemCount: state.blogs.length > 5 ? 5 : state.blogs.length,
                  ),
                ),
                Text(
                  'Blog Yazıları',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) => CustomCard(
                      blog: state.blogs[index],
                    ),
                    itemCount: state.blogs.length,
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: Text(
            "Bilinmedik durum...",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
