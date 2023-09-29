// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:twitter/cubits/user_data/user_data_cubit.dart';
// import 'package:twitter/cubits/website/website_cubit.dart';
// import 'package:twitter/data/models/websites/website_field_keys.dart';
// import 'package:twitter/presentation/auth/widgets/global_button.dart';
// import 'package:twitter/presentation/auth/widgets/phone_number_text_field_.dart';
// import 'package:twitter/utils/colors/app_colors.dart';
// import 'package:twitter/utils/ui_utils/error_message_dialog.dart';
//
// import '../../../auth/widgets/global_text_fields.dart';
//
//
// class AddWebSiteScreen extends StatefulWidget {
//   const AddWebSiteScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddWebSiteScreen> createState() => _AddWebSiteScreenState();
// }
//
// class _AddWebSiteScreenState extends State<AddWebSiteScreen> {
//
//   ImagePicker picker = ImagePicker();
//
//
//
//   String phone = '';
//
//   var maskFormatter = MaskTextInputFormatter(
//       mask: '## ### ## ##',
//       filter: {"#": RegExp(r'[0-9]')},
//       type: MaskAutoCompletionType.lazy);
//
//   FocusNode focusNode = FocusNode();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.c_0C1A30,
//       appBar: AppBar(
//         title: Text('WebSite Add Screen'),
//         backgroundColor: AppColors.c_0C1A30,
//         elevation: 0,
//       ),
//       body: BlocConsumer<WebsiteCubit, WebsiteState>(
//         builder: (context, state){
//           return Padding(
//             padding: const EdgeInsets.all(10),
//             child: ListView(children: [
//               GlobalTextField(
//                 prefixIcon: Icons.person,
//                 hintText: "Name",
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//                 textAlign: TextAlign.start,
//                 onChanged: (v){
//                   context.read<WebsiteCubit>().updateWebsiteField(fieldKey: WebsiteFieldKeys.name, value: v);
//                 },
//               ),
//               SizedBox(height: 20,),
//               GlobalTextField(
//                 prefixIcon: Icons.link_off_outlined,
//                 hintText: "Link",
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//                 textAlign: TextAlign.start,
//                 onChanged: (v){
//                   context.read<WebsiteCubit>().updateWebsiteField(fieldKey: WebsiteFieldKeys.link, value: v);
//                 },
//               ),
//               SizedBox(height: 20,),
//               GlobalTextField(
//                 prefixIcon: Icons.supervised_user_circle_rounded,
//                 hintText: "Author",
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//                 textAlign: TextAlign.start,
//                 onChanged: (v){
//                   context.read<WebsiteCubit>().updateWebsiteField(fieldKey: WebsiteFieldKeys.author, value: v);
//                 },
//               ),
//               SizedBox(height: 20,),
//               PhoneTextField(
//                 maskFormaters: maskFormatter,
//                 focusNode: focusNode,
//                 prefixIcon: Icons.call,
//                 hintText: "Phone",
//                 keyboardType: TextInputType.phone,
//                 textInputAction: TextInputAction.next,
//                 textAlign: TextAlign.start,
//                 onChanged: (v){
//                   phone = v;
//                   if(v.length == 12){
//                     focusNode.unfocus();
//                   }
//                 },
//               ),
//               SizedBox(height: 20,),
//
//               SizedBox(height: 24,),
//               TextButton(onPressed: (){
//                 showBottomSheetDialog();
//               }, child: Text('Select Image')),
//               SizedBox(height: 60,),
//               GlobalButton(title: 'Add', onTap: (){
//                 context.read<WebsiteCubit>().updateWebsiteField(fieldKey: WebsiteFieldKeys.contact, value: phone.replaceAll(" ", ''));
//                 if(BlocProvider.of<WebsiteCubit>(context).state.canAddWebsite()){
//                   context.read<WebsiteCubit>().createWebsite();
//                   Navigator.pop(context);
//                 }else{
//                   showErrorMessage(message: 'Malumotlar toliq emas', context: context);
//                 }
//               }),
//             ],),
//           );
//         },
//         listener: (context, state){
//
//         },
//       ),
//     );
//   }
//
//   void showBottomSheetDialog() {
//     showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(24),
//           height: 200,
//           decoration: BoxDecoration(
//             color: AppColors.c_162023,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(16),
//               topRight: Radius.circular(16),
//             ),
//           ),
//           child: Column(
//             children: [
//               ListTile(
//                 onTap: () {
//                   _getFromCamera();
//                   Navigator.pop(context);
//                 },
//                 leading: const Icon(Icons.camera_alt,color: AppColors.passiveTextColor,),
//                 title: const Text("Select from Camera",style: TextStyle(color: AppColors.passiveTextColor),),
//               ),
//               ListTile(
//                 onTap: () {
//                   _getFromGallery();
//                   Navigator.pop(context);
//                 },
//                 leading: const Icon(Icons.photo,color: AppColors.passiveTextColor,),
//                 title: const Text("Select from Gallery",style: TextStyle(color: AppColors.passiveTextColor),),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _getFromCamera() async {
//     XFile? xFile = await picker.pickImage(
//       source: ImageSource.camera,
//       maxHeight: 512,
//       maxWidth: 512,
//     );
//
//     if (xFile != null && context.mounted) {
//       context.read<WebsiteCubit>().updateWebsiteField(
//         fieldKey: WebsiteFieldKeys.image,
//         value: xFile.path,
//       );
//       setState(() {
//
//       });
//     }
//   }
//
//   Future<void> _getFromGallery() async {
//     XFile? xFile = await picker.pickImage(
//       source: ImageSource.gallery,
//       maxHeight: 512,
//       maxWidth: 512,
//     );
//     if (xFile != null && context.mounted) {
//       context.read<WebsiteCubit>().updateWebsiteField(
//         fieldKey: WebsiteFieldKeys.image,
//         value: xFile.path,
//       );
//       setState(() {
//
//       });
//     }
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:twitter/cubits/website_add/website_add_cubit.dart';
import 'package:twitter/cubits/website_fetch/website_fetch_cubit.dart';
import 'package:twitter/data/models/status/form_status.dart';
import 'package:twitter/presentation/auth/widgets/global_button.dart';
import 'package:twitter/presentation/auth/widgets/global_text_fields.dart';
import 'package:twitter/presentation/auth/widgets/phone_number_text_field_.dart';
import 'package:twitter/utils/colors/app_colors.dart';
import 'package:twitter/utils/ui_utils/error_message_dialog.dart';

import '../../../../data/models/websites/website_field_keys.dart';

class AddWebSiteScreen extends StatefulWidget {
  const AddWebSiteScreen({super.key});

  @override
  State<AddWebSiteScreen> createState() => _AddWebSiteScreenState();
}

class _AddWebSiteScreenState extends State<AddWebSiteScreen> {
  ImagePicker picker = ImagePicker();

  var maskFormatter = MaskTextInputFormatter(
      mask: '## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  FocusNode focusNode = FocusNode();

  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.c_0C1A30,
        title: const Text("Add Website "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<WebsiteAddCubit, WebsiteAddState>(
          buildWhen: (current, previuos) {
            return previuos != current;
          },
          listener: (context, state) {
            if (state.status == FormStatus.failure) {
              showErrorMessage(message: state.statusText, context: context);
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                GlobalTextField(
                  prefixIcon: Icons.link_off_outlined,
                  hintText: "Link",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    context.read<WebsiteAddCubit>().updateWebsiteField(
                      fieldKey: WebsiteFieldKeys.link,
                      value: v,
                    );
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                GlobalTextField(
                  prefixIcon: Icons.person,
                  hintText: "Name",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    context.read<WebsiteAddCubit>().updateWebsiteField(
                      fieldKey: WebsiteFieldKeys.name,
                      value: v,
                    );
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                GlobalTextField(
                  prefixIcon: Icons.supervised_user_circle_rounded,
                  hintText: "Author",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    context.read<WebsiteAddCubit>().updateWebsiteField(
                      fieldKey: WebsiteFieldKeys.author,
                      value: v,
                    );
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                PhoneTextField(
                  focusNode: focusNode,
                  maskFormaters: maskFormatter,
                  prefixIcon: Icons.call,
                  hintText: "Phone",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    if (v.length == 12) {
                      focusNode.unfocus();
                    }
                    phone = v;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                GlobalTextField(
                  prefixIcon: Icons.fence,
                  hintText: "Hashtag",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    context.read<WebsiteAddCubit>().updateWebsiteField(
                      fieldKey: WebsiteFieldKeys.hashtag,
                      value: v,
                    );
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                if (context
                    .read<WebsiteAddCubit>()
                    .state
                    .websiteModel
                    .image
                    .isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: Image.file(
                        File(context
                            .read<WebsiteAddCubit>()
                            .state
                            .websiteModel
                            .image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    showBottomSheetDialog();
                  },
                  child: const Text('Select Image'),
                ),
                GlobalButton(
                  onTap: () {
                    context.read<WebsiteAddCubit>().updateWebsiteField(
                        fieldKey: WebsiteFieldKeys.contact,
                        value: phone.replaceAll(' ', ''));
                    debugPrint(context.read<WebsiteAddCubit>().state.websiteModel.contact);
                    if (context.read<WebsiteAddCubit>().state.canAddWebsite()) {
                      context.read<WebsiteAddCubit>().createWebsite(context);
                      context.read<WebsiteAddCubit>().updateWebsiteField(
                          fieldKey: WebsiteFieldKeys.image, value: '');
                      context.read<WebsiteFetchCubit>().getWebsites(context);
                      Navigator.pop(context);
                    } else {
                      showErrorMessage(
                          message: "Ma'lumotlar to'liq emas!!!",
                          context: context);
                    }
                  },
                  title: 'Add Websitee',
                )
              ],
            );
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
                  Icons.camera_alt,
                  color: AppColors.passiveTextColor,
                ),
                title: const Text(
                  "Select from Camera",
                  style: TextStyle(color: AppColors.passiveTextColor),
                ),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.photo,
                  color: AppColors.passiveTextColor,
                ),
                title: const Text(
                  "Select from Gallery",
                  style: TextStyle(color: AppColors.passiveTextColor),
                ),
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
      context.read<WebsiteAddCubit>().updateWebsiteField(
        fieldKey: WebsiteFieldKeys.image,
        value: xFile.path,
      );
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      context.read<WebsiteAddCubit>().updateWebsiteField(
        fieldKey: WebsiteFieldKeys.image,
        value: xFile.path,
      );
    }
  }
}
