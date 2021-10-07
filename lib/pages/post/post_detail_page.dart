import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/controllers/auth/auth_controller.dart';
import 'package:hizliflutter/controllers/favorite_controller.dart';
import 'package:hizliflutter/controllers/post_controller.dart';
import 'package:hizliflutter/models/post.dart';
import 'package:hizliflutter/services/functions.dart';

class PostDetailPage extends StatelessWidget {
  Post model;

  PostDetailPage(this.model);

  final FavoriteController fetchController = Get.put(FavoriteController());
  final PostController postController = Get.put(PostController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(model.heading),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: postView(),
    );
  }

  postView() {
    Widget cesit;
    switch (model.type) {
      case 'Layout':
        cesit = Text(
          model.type,
          style: TextStyle(
            color: Colors.yellow[900].withOpacity(.7),
          ),
        );
        break;
      case 'Widget':
        cesit = Text(
          model.type,
          style: TextStyle(
            color: Colors.blue.withOpacity(.7),
          ),
        );
        break;
      default:
        cesit = Text(
          model.type,
          style: TextStyle(
            color: Color(
              (Random().nextDouble() * 0xFFFFFF).toInt(),
            ).withOpacity(1.0),
          ),
        );
    }
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(children: [
                          Container(
                            width: 45,
                            height: 45,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                model.type[0],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      model.heading,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    model.content,
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ]),
                          )
                        ]),
                      ),
                      GestureDetector(
                        onTap: () => fetchController.favWidget(
                            type: FavType.Post, id: model.id),
                        child: Obx(
                          () => AnimatedContainer(
                              height: 35,
                              padding: EdgeInsets.all(5),
                              duration: Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: (fetchController
                                                .isFavPostList[model.id]) &&
                                            fetchController
                                                    .isFavPostList[model.id] !=
                                                null
                                        ? Colors.red.shade100
                                        : Colors.grey.shade300,
                                  )),
                              child: Center(
                                  child: (fetchController
                                              .isFavPostList[model.id]) &&
                                          fetchController
                                                  .isFavPostList[model.id] !=
                                              null
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.favorite_outline,
                                          color: Colors.grey.shade600,
                                        ))),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.shade200),
                              child: cesit,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            /*Container(
                              padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text('@'+
                                s.postList[index].userName,
                              ),
                            ),*/
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      model.userName,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(CupertinoIcons.profile_circled),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      Functions.convertToAgo(model.createdAt),style: TextStyle(color: Colors.black54),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.watch_later_outlined,
                                      size: 20,color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        /* Text(
                          '2 Saat Önce',
                          style: TextStyle(
                              color: Colors.grey.shade800, fontSize: 12),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
            addCommentView(),
            model.comments != null ? commentsView() : Container(),
          ],
        ),
      ),
    );
  }

  commentsView() {
    return Container(
      width: Get.width,
      height: Get.height * 0.5,
      child: ListView.builder(
        itemCount: model.comments.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.4,
                  child: Text(
                    model.comments[index].content,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.comments[index].userName,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(CupertinoIcons.profile_circled),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            Functions.convertToAgo(
                                model.comments[index].createdAt),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.watch_later_outlined,
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  addCommentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Form(
          key: postController.addCommentFormKey,
          child: TextFormField(
            controller: postController.addCommentController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Boş olamaz!';
              }
              if (value.length < 5) {
                return 'En az 5 karakter girmelisiniz!';
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        MaterialButton(
          onPressed: () => toComment(),
          child: Obx(
            () => postController.isLoading.value
                ? CircularProgressIndicator()
                : Text('Yorum Yap'),
          ),
        ),
      ],
    );
  }

  toComment() async {
    await postController.addComment(
        model.id, authController.user.value.id, authController.user.value.name);
  }
}
