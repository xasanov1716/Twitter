import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ArticleModel extends Equatable{
  final int artId;
  final String image;
  final String title;
  final String description;
  final String likes;
  final String hashtag;
  final String views;
  final String addDate;
  final String username;
  final String avatar;
  final String profession;
  final int userId;

  ArticleModel({
    required this.hashtag,
    required this.profession,
    required this.userId,
    required this.likes,
    required this.artId,
    required this.image,
    required this.description,
    required this.views,
    required this.title,
    required this.avatar,
    required this.addDate,
    required this.username,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      hashtag: json['hashtag'] as String? ?? '',
      userId: json["user_id"] as int? ?? 0,
      profession: json["profession"] as String? ?? "",
      likes: json["likes"] as String? ?? "",
      artId: json["art_id"] as int? ?? 0,
      image: json["image"] as String? ?? "",
      description: json["description"] as String? ?? "",
      views: json["views"] as String? ?? "",
      title: json["title"] as String? ?? "",
      avatar: json["avatar"] as String? ?? "",
      addDate: json["add_date"] as String? ?? "",
      username: json["username"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "profession": profession,
      "userId": userId,
      "title": title,
      "description": description,
      "likes": likes,
      "views": views,
      "addDate": addDate,
      "username": username,
      "avatar": avatar,
    };
  }

  Future<FormData> getFormData() async {
    XFile file = XFile(image);
    String fileName = file.path.split('/').last;
    return FormData.fromMap({
      "hashtag":hashtag,
      "title":title,
      "description":description,
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
  }


  ArticleModel copyWith({
  String? image,
  String? profession,
  int? userId,
  String? title,
  String? description,
  String? likes,
  String? views,
  String? addDate,
    int? artId,
    String? hashtag,
  String? username,
    String? avatar,
  }) =>
      ArticleModel(
        image: image ?? this.image,
        hashtag: hashtag ?? this.hashtag,
        profession: profession ?? this.profession,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        description: description ?? this.description,
        views: views ?? this.views,
        addDate: addDate ?? this.addDate,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar, likes: likes ?? this.likes, artId: artId ?? this.artId,
      );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}