
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:twitter/cubits/website_fetch/website_fetch_cubit.dart';
import 'package:twitter/data/models/status/form_status.dart';
import 'package:twitter/data/models/websites/website_model.dart';
import 'package:twitter/presentation/app_routes.dart';
import 'package:twitter/utils/colors/app_colors.dart';
import 'package:twitter/utils/ui_utils/error_message_dialog.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';



class WebsiteScreen extends StatefulWidget {
  const WebsiteScreen({Key? key}) : super(key: key);

  @override
  State<WebsiteScreen> createState() => _WebsiteScreenState();
}

class _WebsiteScreenState extends State<WebsiteScreen> {

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    Future.microtask(
            () => BlocProvider.of<WebsiteFetchCubit>(context).getWebsites(context));
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
                      Navigator.pushNamed(context, RouteNames.addWebSite);
          }, icon: const Icon(Icons.add)),
        ],
        backgroundColor: AppColors.c_0C1A30,
        title: Text('WebsiteScreen'),
      ),
      body: BlocConsumer<WebsiteFetchCubit, WebsiteFetchState>(
        builder: (context, state){
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: state.websites.length,
                  itemBuilder: (BuildContext context, int index) {
                    WebsiteModel websiteModel = state.websites[index];
                    return ZoomTapAnimation(
                      onTap: (){
                        context.read<WebsiteFetchCubit>().getWebsiteById(websiteModel.id);
                        Navigator.pushNamed(context, RouteNames.webSiteDetail);
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
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        'http://159.89.98.34:5545${websiteModel.image}',
                                        height: 200,
                                        width: 360,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>  Center(
                                            child: CupertinoActivityIndicator(
                                              color: AppColors.white,
                                            )),
                                        errorWidget: (context, url, error) => Icon(
                                          Icons.language,size: 90,
                                          color: AppColors.c_EDEDED,
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
                                      websiteModel.name,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      websiteModel.author,
                                      maxLines: 1,
                                      style:  TextStyle(
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColors.c_3669C9),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 8,),
                                  Text(
                                    websiteModel.hashtag,
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                   const   LikeButton(),
                                      Text(websiteModel.likes,style: TextStyle(color: AppColors.passiveTextColor),),
                                    ],
                                  ),
                                  SizedBox(width: 10,)
                                ],
                              )
                            ],
                          )),
                    );
                  },
                );
        },
        listener: (context, state){
            if(state.status == FormStatus.failure){
              showErrorMessage(message: state.statusText, context: context);
            }
            if(state.statusText == 'website_added'){
              context.read<WebsiteFetchCubit>().getWebsites(context);
            }
        },
      ),
    );
  }
}
