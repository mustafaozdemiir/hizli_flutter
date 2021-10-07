import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/controllers/auth/auth_controller.dart';
import 'package:hizliflutter/controllers/favorite_controller.dart';
import 'package:hizliflutter/models/comment.dart';
import '../app_string.dart';
import '../main.dart';
import '/models/post.dart';
import 'package:http/http.dart' as http;

enum PostType {
  Question,
  News,
  Plugin,
  Library,
}

class PostController extends GetxController {
  final postFormKey = GlobalKey<FormState>();
  FavoriteController fetchController = Get.put(FavoriteController());
  AuthController authController = Get.put(AuthController());

  TextEditingController headingPostController;
  TextEditingController contentPostController;
  Rx<PostType> typeController = PostType.Question.obs;

  var isLoading = false.obs;

  List<Post> postList;

  TextEditingController addCommentController;
  final addCommentFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    headingPostController = TextEditingController();
    contentPostController = TextEditingController();
    addCommentController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    headingPostController.dispose();
    contentPostController.dispose();
    addCommentController.dispose();
    fetchController.dispose();
  }

  Future<void> getPostsApi() async {
    try {
      final http.Response response = await http
          .get(Uri.parse(AppString.webUrl + AppString.webDataUrl + 'posts'))
          .timeout(Duration(seconds: 3), onTimeout: () {
        print('TimeOut GetPostApi');
      });

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        postList = <Post>[].obs;

        for (var model in parsedJson) {
          postList.add(
            Post.fromJson(model),
          );
          bool isFavPost = false;
          await fetchController.isFav(
                  type: FavType.Post, id: Post.fromJson(model).id)
              .then((value) {
            isFavPost = value;
          });
          fetchController.isFavPostList[Post.fromJson(model).id] = isFavPost;
        }
        postList = postList.reversed.toList();
      } else {
        print('Hata var');
      }
    } on TimeoutException catch (_) {}

    update();
  }

  addPost() async {
    if (postFormKey.currentState.validate()) {
      isLoading.value = true;
      String postType = '';
      switch (typeController.value) {
        case PostType.Question:
          postType = 'Soru';
          break;
        case PostType.News:
          postType = 'Haber';
          break;
        case PostType.Library:
          postType = 'Kütüphane';
          break;
        case PostType.Plugin:
          postType = 'Eklenti';
          break;
      }
      Post post = Post();
      post.content = contentPostController.text;
      post.heading = headingPostController.text;
      post.type = postType;
      post.userName = authController.user.value.name;
      post.userId = authController.user.value.id;
      post.numberOfComment = 0;
      post.numberOfLikes = 0;
      var response = await http.post(Uri.parse(
          AppString.webUrl + AppString.webDataUrl + 'post'),
          body: jsonEncode(post.toJson()),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + authController.user.value.token,
          });
      if (response.statusCode > 400 || response.statusCode < 200) {
        isLoading.value = false;
        Get.snackbar('Hata', jsonDecode(response.body)['message']);
      } else if (200 <= response.statusCode && response.statusCode < 400) {
        headingPostController.clear();
        contentPostController.clear();
        typeController.value = PostType.Question;
        isLoading.value = false;
        await Get.offAll(MyHomePage());
        Get.snackbar('Başarılı', 'Gönderiniz başarıyla eklendi');
      }
    }
  }

  addComment(int postId, int userId, String userName) async {
    if (addCommentFormKey.currentState.validate()) {
      isLoading.value = true;
      Comment comment = Comment();
      comment.numberOfLikes = 0;
      comment.content = addCommentController.text;
      comment.postId = postId;
      comment.userId = userId;
      comment.userName = userName;

      var response = await http.post(
          Uri.parse(AppString.webUrl + AppString.webDataUrl + 'comment'),
          body: jsonEncode(comment.toJson()),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + authController.user.value.token,
          });
      if (response.statusCode > 400 || response.statusCode < 200) {
        isLoading.value = false;
        Get.snackbar('Hata', jsonDecode(response.body)['message'].toString());
      } else if (200 <= response.statusCode && response.statusCode < 400) {
        getPostsApi();
        addCommentController.clear();
        isLoading.value = false;
        Get.back();
        Get.back();
        Get.snackbar('Başarılı', 'Yorumunuz başarıyla eklendi');
      }
    }
  }
}
