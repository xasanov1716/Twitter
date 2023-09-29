import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:twitter/cubits/article_fetch/article_fetch_cubit.dart';
import 'package:twitter/data/models/articles/articles_model.dart';
import 'package:twitter/presentation/app_routes.dart';
import 'package:twitter/utils/colors/app_colors.dart';
import 'package:twitter/utils/constants/constants.dart';
import 'package:twitter/utils/ui_utils/error_message_dialog.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  void initState() {
    context.read<ArticleFetchCubit>().fetchArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, RouteNames.addArticle);
          }, icon: Icon(Icons.add))
        ],
        backgroundColor: AppColors.c_0C1A30,
        elevation: 0,
        title: const Text("Article Screen"),
      ),
      body: BlocConsumer<ArticleFetchCubit, ArticleFetchState>(
        buildWhen: (current, previous){
          return current != previous;
        },
        listener: (context, state) {
          if (state is ArticleLoadingState) {
            const Center(
              child: CupertinoActivityIndicator(radius: 15,color: AppColors.passiveTextColor,),
            );
          }
          if (state is ArticleErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
        builder: (context, state) {
          if (state is ArticleGetState) {
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 20,
              ),
              itemCount: state.articleModel.length,
              itemBuilder: (BuildContext context, int index) {
                ArticleModel articleModel = state.articleModel[index];
                return ZoomTapAnimation(
                  onTap: (){
                    Navigator.pushNamed(context, RouteNames.articleDetail, arguments: {
                      'article': articleModel,
                      'index':index
                    },);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.c_273032,
                        borderRadius: BorderRadius.circular(26)
                    ),
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, top: 14, bottom: 14),
                      child: Column(
                        children: [
                          Stack(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(26),topRight: Radius.circular(26)),
                                  child: Hero(tag: 'tag$index',
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '$baseUrlImage${articleModel.avatar}',
                                      height: 200,
                                      width: 360,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>  Center(
                                          child: CupertinoActivityIndicator(
                                        color: AppColors.white,
                                      )),
                                      errorWidget: (context, url, error) => Icon(
                                        Icons.error,
                                        color: AppColors.c_C93545,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    Column(
                                      children: [
                                        const LikeButton(),
                                        Text(
                                          articleModel.likes,
                                          style: const TextStyle(
                                              color:
                                                  AppColors.passiveTextColor),
                                        ),
                                        const Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: AppColors.passiveTextColor,
                                        ),
                                        Text(
                                          articleModel.views,
                                          style: const TextStyle(
                                              color:
                                                  AppColors.passiveTextColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ],
                            )
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  articleModel.title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColors.passiveTextColor),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              articleModel.description,
                              maxLines: 3,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.passiveTextColor),
                            ),
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                articleModel.addDate,
                                style: TextStyle(color: AppColors.white),
                              ),
                              const SizedBox(
                                width: 8,
                              )
                            ],
                          )
                        ],
                      )),
                );
              },
            );
          }
          return  Center(
            child: CupertinoActivityIndicator(color: AppColors.white,),
          );
        },
      ),
    );
  }
}
