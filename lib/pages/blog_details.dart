import 'package:blog_app/constants/constants.dart';
import 'package:blog_app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogDetails extends StatefulWidget {
  const BlogDetails({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: ScreenUtil.getHeight(context) * 0.6,
            width: ScreenUtil.getWidth(context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/background_image.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Blog Title',
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
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Author Name',
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_square),
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              height: ScreenUtil.getHeight(context) * 0.55,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit eros quis viverra suscipit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent semper aliquam velit non sagittis. Ut imperdiet volutpat erat, quis blandit velit commodo auctor. Nulla fermentum odio tellus, nec scelerisque leo tristique a. In pretium diam quis erat sagittis, nec fermentum ipsum viverra. Integer dolor odio, ultrices non libero ac, commodo ultrices orci. Nullam non felis elit. Curabitur eu magna venenatis, aliquet purus nec, pretium libero. Morbi mauris ipsum, sagittis et porta et, aliquet sed eros. Morbi ligula ipsum, dignissim in quam a, vestibulum interdum lectus. In rhoncus sapien non consequat eleifend. In consequat ullamcorper massa, nec posuere ipsum sagittis sed. Quisque leo ligula, pellentesque id ultricies sed, malesuada in erat. Praesent id urna eu ex laoreet iaculis sed non dolor. Donec in erat ut leo consectetur suscipit vitae vitae nisl. Nulla a metus lacinia, laoreet velit at, ultricies est. Donec vel consectetur turpis. Phasellus euismod ligula ac convallis dapibus. Etiam vitae dictum mi, eu posuere metus. Nulla gravida massa non ligula gravida tempor. Phasellus mi elit, vestibulum non efficitur quis, porta non augue. Curabitur porttitor erat non enim fringilla, vel lacinia ante tempus. Aliquam in ex ipsum. Nulla nulla libero, pharetra vel diam eget, pellentesque lobortis dui. Phasellus id arcu eget lectus pellentesque suscipit eu tristique massa. Pellentesque quis ornare erat.",
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
