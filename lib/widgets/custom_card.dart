import 'package:blog_app/constants/constants.dart';
import 'package:blog_app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  final String blogTitle;
  final String blogContent;
  final String imagePath;
  final String authorName;
  final bool isLastAdded;
  const CustomCard({
    super.key,
    this.isLastAdded = false,
    required this.blogTitle,
    required this.blogContent,
    required this.imagePath,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetails(
                blogTitle: blogTitle,
                blogContent: blogContent,
                imagePath: imagePath,
                authorName: authorName),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
        width: ScreenUtil.getWidth(context) * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          image: isLastAdded
              ? DecorationImage(
                  image: NetworkImage(
                    imagePath,
                  ),
                  fit: BoxFit.cover)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(
                2.0,
                2.0,
              ),
              blurRadius: 2,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          children: [
            if (!isLastAdded) ...[
              Container(
                margin: const EdgeInsets.only(right: 8),
                height: ScreenUtil.getHeight(context) * 0.1,
                width: ScreenUtil.getHeight(context) * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(
                      imagePath,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    blogTitle,
                    style: GoogleFonts.poppins(
                      color: isLastAdded ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    blogContent,
                    style: GoogleFonts.poppins(
                      color: isLastAdded ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                    maxLines: isLastAdded ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: ScreenUtil.getHeight(context) * 0.033,
                        width: ScreenUtil.getHeight(context) * 0.033,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        authorName,
                        style: GoogleFonts.poppins(
                          color: isLastAdded ? Colors.white : Colors.black,
                          fontSize: 12,
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
    );
  }
}
