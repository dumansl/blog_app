import 'dart:io';

import 'package:blog_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class BlogEditScreen extends StatefulWidget {
  const BlogEditScreen({super.key});

  @override
  State<BlogEditScreen> createState() => _BlogEditScreenState();
}

class _BlogEditScreenState extends State<BlogEditScreen> {
  final FocusNode _focusNode = FocusNode();
  File? image;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blog Edit",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              editFrame(
                child: TextFormField(
                  autofocus: true,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    labelText: 'Blog Başlığı',
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  maxLines: 1,
                  maxLength: 100,
                ),
              ),
              editFrame(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Blog İçeriği',
                    isDense: true,
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    border: InputBorder.none,
                  ),
                  maxLines: 7,
                  maxLength: 500,
                ),
              ),
              editFrame(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Yazar',
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  maxLines: 1,
                ),
              ),
              InkWell(
                onTap: _getImage,
                child: editFrame(
                  child: Text(
                    "Resim Ekle",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: ScreenUtil.getHeight(context) * 0.09,
                    width: ScreenUtil.getWidth(context) * 0.5,
                    child: editFrame(
                      child: Center(
                        child: Text(
                          "GÖNDER",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget editFrame({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
      child: child,
    );
  }
}
