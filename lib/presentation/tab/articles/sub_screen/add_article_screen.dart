import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:twitter/cubits/article_add/article_add_cubit.dart';
import 'package:twitter/cubits/article_add/article_add_state.dart';
import 'package:twitter/cubits/article_fetch/article_fetch_cubit.dart';
import 'package:twitter/data/models/articles/articles_model.dart';
import 'package:twitter/presentation/auth/widgets/global_button.dart';
import 'package:twitter/presentation/auth/widgets/global_text_fields.dart';
import 'package:twitter/utils/colors/app_colors.dart';
import 'package:twitter/utils/ui_utils/error_message_dialog.dart';

import '../../../../utils/ui_utils/loading_dialog.dart';


class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({Key? key}) : super(key: key);

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {


  ImagePicker picker = ImagePicker();

  XFile? file;

  String title = '';
  String description = '';
  String hashtag = '';

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.c_0C1A30,
        appBar: AppBar(
          backgroundColor: AppColors.c_0C1A30,
          elevation: 0,
          title: const Text('Article Add Screen'),
        ),
        body: BlocConsumer<ArticleAddCubit, ArticleAddState>(
          builder: (context, state) {
            if(state is ArticleAddLoadingState){
              return Center(child: CupertinoActivityIndicator(radius: 15,color: AppColors.white,));
            }

            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height/1.1,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      GlobalTextField(
                        prefixIcon: Icons.title,
                        hintText: "Title",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        onChanged: (v) {
                          title = v;
                        },
                      ),
                      SizedBox(height: 16,),
                      GlobalTextField(
                        prefixIcon: Icons.description,
                        maxLine: 5,
                        hintText: "Description",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        onChanged: (v) {
                          description = v;
                        },
                      ),
                     const SizedBox(height: 16,),
                      GlobalTextField(
                        prefixIcon: Icons.fence,
                        hintText: "Hashtag",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.start,
                        onChanged: (v) {
                          hashtag = v;
                        },
                      ),
                      Row(
                        children: [
                       const   Spacer(),
                          IconButton(onPressed: () {
                            showBottomSheetDialog();
                          }, icon: Icon(Icons.image, color: AppColors.white,)),
                        const  SizedBox(width: 24,)
                        ],
                      ),
                      file != null? ClipRRect(borderRadius: BorderRadius.circular(26),child: Image.file(File(file!.path),fit: BoxFit.cover,width: 90,height: 90,)): const SizedBox(),
                      const Spacer(),
                      GlobalButton(title: 'Add', onTap: () {
                        if (file != null && title.isNotEmpty &&
                            description.isNotEmpty) {
                          context.read<ArticleAddCubit>().createArticles(
                              articleModel: ArticleModel(
                                  hashtag: '#${hashtag}',
                                  profession: '',
                                  userId: 0,
                                  likes: 'likes',
                                  artId: 0,
                                  image: file!.path,
                                  description: description,
                                  views: 'views',
                                  title: title,
                                  avatar: '',
                                  addDate: DateTime.now().toString(),
                                  username: 'xasanov'));
                          showErrorMessage(message: 'Article added', context: context);
                          Navigator.pop(context);
                        }
                        else {
                          showErrorMessage(
                              message: 'Fields are not full', context: context);
                        }
                      })
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if(state is ArticleAddSuccessCreateState){
              hideLoading(context: context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('Article Added'))));
              // showErrorMessage(message: 'Article added', context: context);
            }
          },
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.c_162023,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.camera_alt, color: AppColors.passiveTextColor,),
                title: const Text("Select from Camera",
                  style: TextStyle(color: AppColors.passiveTextColor),),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.photo, color: AppColors.passiveTextColor,),
                title: const Text("Select from Gallery",
                  style: TextStyle(color: AppColors.passiveTextColor),),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null && context.mounted) {
      file = xFile;
      setState(() {

      });
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      file = xFile;
      setState(() {

      });
    }
  }

}
