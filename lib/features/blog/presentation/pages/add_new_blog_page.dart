import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController(text: "");
  final contentController = TextEditingController(text: "");
  final formKey = GlobalKey<FormState>();

  List<String> selectedTopic = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    setState(() {
      image = pickedImage;
    });
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopic.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
            BlogUpload(
                posterId: posterId,
                title: titleController.text,
                content: contentController.text,
                image: image!,
                topics: selectedTopic),
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              uploadBlog();
            },
            icon: const Icon(Icons.done_rounded),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          } else if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BlogPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                              color: AppPalette.borderColor,
                              dashPattern: const [10, 4],
                              radius: const Radius.circular(10),
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.round,
                              strokeWidth: 2.0,
                              child: const SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40.0,
                                    ),
                                    SizedBox(
                                      height: 15,
                                      width: double.infinity,
                                    ),
                                    Text(
                                      "Select your image",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          "Technology",
                          "Business",
                          "Programming",
                          "Entertainment",
                        ]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedTopic.contains(e)) {
                                      selectedTopic.remove(e);
                                    } else {
                                      selectedTopic.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(e),
                                    color: selectedTopic.contains(e)
                                        ? const WidgetStatePropertyAll(
                                            AppPalette.gradient1)
                                        : null,
                                    side: selectedTopic.contains(e)
                                        ? null
                                        : const BorderSide(
                                            color: AppPalette.borderColor),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    BlogEditor(
                        controller: titleController, hintText: "Blog Title"),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogEditor(
                        controller: contentController, hintText: "Blog content")
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
