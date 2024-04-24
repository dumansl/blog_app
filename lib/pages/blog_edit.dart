import 'package:blog_app/blocs/articles/article_bloc.dart';
import 'package:blog_app/blocs/articles/article_event.dart';
import 'package:blog_app/blocs/articles/article_state.dart';
import 'package:blog_app/models/blog.dart';
import 'package:blog_app/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blog_app/constants/constants.dart';

class BlogEditScreen extends StatefulWidget {
  const BlogEditScreen({super.key});

  @override
  State<BlogEditScreen> createState() => _BlogEditScreenState();
}

class _BlogEditScreenState extends State<BlogEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  XFile? _image;
  bool _isImageSelected = false;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
        _isImageSelected = true;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final blog = Blog(
        title: _titleController.text,
        content: _contentController.text,
        author: _authorController.text,
        thumbnail: _image?.path,
      );

      context.read<ArticleBloc>().add(AddArticle(blog));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArticleBloc, ArticleState>(
      listener: (context, state) {
        if (state is ArticleAdded) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomAlertDialog(
                text: "Başarılı",
                content: 'Blog başarıyla gönderildi.',
                buttonText: 'Tamam',
                onPressed: () {
                  Navigator.of(context).pop();
                  _titleController.clear();
                  _contentController.clear();
                  _authorController.clear();
                  setState(
                    () {
                      _image = null;
                      _isImageSelected = false;
                    },
                  );
                },
              );
            },
          );
        } else if (state is ArticlesLoadFail) {
          CustomAlertDialog(
            text: 'Hata',
            content: 'Blog gönderilirken bir hata oluştu.',
            buttonText: 'Tamam',
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Blog Ekleme",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  editFrame(
                    child: TextFormField(
                      controller: _titleController,
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
                      controller: _contentController,
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
                      controller: _authorController,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                      if (_isImageSelected)
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Icon(Icons.check_box, color: Colors.green),
                        ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: InkWell(
                      onTap: _submit,
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
