import 'package:blog_app/models/blog.dart';
import 'package:blog_app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  final Blog blog;
  final bool isLastAdded;
  const CustomCard({
    super.key,
    this.isLastAdded = false,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetails(blog: blog),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          image: isLastAdded
              ? DecorationImage(
                  image: NetworkImage(blog.thumbnail!),
                  fit: BoxFit.cover,
                )
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
        child: Stack(
          children: [
            if (isLastAdded)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (!isLastAdded) ...[
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(blog.thumbnail!),
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
                          blog.title!,
                          style: GoogleFonts.poppins(
                            color: isLastAdded ? Colors.white : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          blog.content!,
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
                              height:
                                  MediaQuery.of(context).size.height * 0.033,
                              width: MediaQuery.of(context).size.height * 0.033,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              blog.author!,
                              style: GoogleFonts.poppins(
                                color:
                                    isLastAdded ? Colors.white : Colors.black,
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
          ],
        ),
      ),
    );
  }
}
