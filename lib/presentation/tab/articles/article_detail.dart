import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter/data/models/articles/articles_model.dart';
import 'package:twitter/utils/colors/app_colors.dart';

import '../../../../utils/constants/constants.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.articleModel, required this.index});

  final ArticleModel articleModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        backgroundColor: AppColors.c_0C1A30,
        elevation: 0,
        title: const Text("Article Detail Screen"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Hero(tag: 'tag$index',
                  child: CachedNetworkImage(
                    imageUrl: "$baseUrlImage${articleModel.avatar}",
                    placeholder: (context, url) => CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, color: AppColors.c_C93545,),),
                ),
              ),

              const Divider(height: 2,color: AppColors.passiveTextColor,endIndent: 20,indent: 20,),
              Container(
                margin: const EdgeInsets.all(16),
                height: 60,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: Row(
                      children: [
                        Text(
                          'UserName: ',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.white),
                        ),
                        Text(articleModel.username,style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.passiveTextColor),),
                      ],
                    )),
              ),
              const Divider(height: 2,color: AppColors.passiveTextColor,endIndent: 20,indent: 20,),
              Container(
                margin: const EdgeInsets.all(16),
                height: 60,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: Row(
                      children: [
                        Text(
                          'Title: ',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.white),
                        ),
                        Text(articleModel.title,style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.passiveTextColor),),
                      ],
                    )),
              ),
              const Divider(height: 2,color: AppColors.passiveTextColor,endIndent: 20,indent: 20,),
              Container(
                margin: const EdgeInsets.all(16),
                height: 60,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: Row(
                      children: [
                        Text(
                          'Profession: ',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.white),
                        ),
                        Text(articleModel.profession,style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.passiveTextColor),),
                      ],
                    )),
              ),
              const Divider(height: 2,color: AppColors.passiveTextColor,endIndent: 20,indent: 20,),
              Container(
                margin: const EdgeInsets.all(16),
                height: 60,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: Row(
                      children: [
                        Text(
                          'Likes: ',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.white),
                        ),
                        Text(articleModel.likes,style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.passiveTextColor),),
                      ],
                    )),
              ),
              const Divider(height: 2,color: AppColors.passiveTextColor,endIndent: 20,indent: 20,),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: Column(
                      children: [
                        Text(articleModel.description,style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.passiveTextColor),),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}