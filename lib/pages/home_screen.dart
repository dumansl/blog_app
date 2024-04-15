import 'package:blog_app/constants/constants.dart';
import 'package:blog_app/pages/pages.dart';
import 'package:blog_app/providers/blog_provider.dart';
import 'package:blog_app/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_square,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BlogEditScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Consumer(
            builder: (context, ref, child) {
              final blogs = ref.watch(blogProvider);
              return blogs.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) =>
                    Center(child: Text('Error: $error')),
                data: (blogs) {
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
                            itemBuilder: (ctx, index) => CustomCard(
                                isLastAdded: true,
                                blogTitle: blogs[index].title,
                                blogContent: blogs[index].content,
                                imagePath: blogs[index].thumbnail,
                                authorName: blogs[index].author),
                            itemCount: blogs.length > 5 ? 5 : blogs.length,
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
                                blogTitle: blogs[index].title,
                                blogContent: blogs[index].content,
                                imagePath: blogs[index].thumbnail,
                                authorName: blogs[index].author),
                            itemCount: blogs.length,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
