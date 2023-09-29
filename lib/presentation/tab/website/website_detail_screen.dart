import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:twitter/cubits/website_fetch/website_fetch_cubit.dart';
import 'package:twitter/data/models/status/form_status.dart';
import 'package:twitter/utils/colors/app_colors.dart';
import 'package:twitter/utils/constants/constants.dart';
import 'package:twitter/utils/ui_utils/error_message_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class WebsiteDetailScreen extends StatefulWidget {
  const WebsiteDetailScreen({Key? key,})
      : super(key: key);


  @override
  State<WebsiteDetailScreen> createState() => _WebsiteDetailScreenState();
}

class _WebsiteDetailScreenState extends State<WebsiteDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
        appBar: AppBar(
          elevation: 0  ,
          backgroundColor: AppColors.c_0C1A30,
          title: const Text('WebsiteDetailScreen'),
        ),
        body: BlocConsumer<WebsiteFetchCubit,WebsiteFetchState>(
          builder: (context,state){
            if(state.websiteDetail == null){
              return const Center(child: CupertinoActivityIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: CachedNetworkImage(
                        imageUrl: baseUrlImage+state.websiteDetail!.image,fit: BoxFit.cover,height: 200,
                        placeholder: (context, url) => CupertinoActivityIndicator(
                          color: AppColors.white,
                        ),
                        errorWidget: (context, url, error) =>  Icon(
                          Icons.language,size: 90,
                          color: AppColors.c_EDEDED,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  'Name: ',
                                  style: TextStyle(
                                      fontSize: 18, color: AppColors.white),
                                ),
                                Text(state.websiteDetail!.name,style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.passiveTextColor),),
                              ],
                            )),
                      ),
                      const   Divider(height: 2,color: AppColors.passiveTextColor,endIndent: 20,indent: 20,),
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
                                  'Phone Number: ',
                                  style: TextStyle(
                                      fontSize: 18, color: AppColors.white),
                                ),
                                ZoomTapAnimation(
                                  onTap: (){
                                    showCallAndMessage(state.websiteDetail!.contact);
                                  },
                                  child: Text('+998 ${state.websiteDetail!.contact}',style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.passiveTextColor),),
                                ),
                              ],
                            )),
                      ),
                      const   Divider(height: 2,color: AppColors.passiveTextColor,endIndent: 20,indent: 20,),
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
                                  'Link: ',
                                  style: TextStyle(
                                      fontSize: 18, color: AppColors.white,overflow: TextOverflow.ellipsis),
                                ),
                                ZoomTapAnimation(
                                  onTap: (){

                                  },
                                  child: Linkify(
                                    onOpen: (link) async {
                                      if (!await launchUrl(Uri.parse(link.url))) {
                                        throw Exception('Could not launch ${link.url}');
                                      }
                                    },
                                    text: state.websiteDetail!.link,
                                    style:const TextStyle(color: Colors.yellow),
                                    linkStyle:const TextStyle(color: Colors.blue),
                                  ),
                                ),
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
                                  'Author: ',
                                  style: TextStyle(
                                      fontSize: 18, color: AppColors.white),
                                ),
                                Text(state.websiteDetail!.author,style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.passiveTextColor),),
                              ],
                            )),
                      ),
                      const  Divider(height: 2,color: AppColors.passiveTextColor,endIndent: 20,indent: 20,),
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
                                  'Hashtag: ',
                                  style: TextStyle(
                                      fontSize: 18, color: AppColors.white),
                                ),
                                Text(state.websiteDetail!.hashtag,style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.passiveTextColor),),
                              ],
                            )),
                      ),
                      const  Divider(height: 2,color: AppColors.passiveTextColor,endIndent: 20,indent: 20,),
                    ],
                  )
                ],
              ),
            );
          },
          listener: (context,state){
            if(state.status == FormStatus.failure){
              showErrorMessage(message: state.statusText, context: context);
            }
          },
        )
    );
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    setState(() {});
  }

  void showCallAndMessage(String number) {
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
                  messageUser(number);
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.message,
                  color: AppColors.passiveTextColor,
                ),
                title: const Text(
                  "Message",
                  style: TextStyle(color: AppColors.passiveTextColor),
                ),
              ),
              ListTile(
                onTap: () {
                  callUser(number);
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.call,
                  color: AppColors.passiveTextColor,
                ),
                title: const Text(
                  "Call",
                  style: TextStyle(color: AppColors.passiveTextColor),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> messageUser(String number) async {
    await launchUrl(Uri.parse('sms:+998$number?body='));
  }

  Future<void> callUser(String number) async {
    await launchUrl(Uri.parse('tel:+998$number'));
  }



}
