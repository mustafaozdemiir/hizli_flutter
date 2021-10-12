import 'dart:math';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/controllers/post_controller.dart';
import 'package:hizliflutter/pages/auth/login_page.dart';
import 'package:hizliflutter/pages/post/add_post_page.dart';
import 'package:hizliflutter/services/functions.dart';
import '../../app_string.dart';
import '/controllers/auth/auth_controller.dart';
import '/controllers/favorite_controller.dart';
import '/models/post.dart';
import 'post_detail_page.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final PostController postController = Get.put(PostController());
  AuthController authController = Get.put(AuthController());

  TextEditingController _searchEdit = TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<Post> _list;
  List<Post> _searchList;

  @override
  void dispose() {
    super.dispose();
    _searchEdit.dispose();
  }

  _PostPageState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(AppString.post),
          actions: [
            Functions.loginLogoutButton(),
          ]),
      backgroundColor: Colors.white,
      body: GetBuilder<PostController>(
        initState: (_) {
          Get.find<PostController>().getPostsApi();
        },
        builder: (s) {
          return s.postList == null
              ? Center(
                  child: Text('Eklenmiş Gönderi Bulunmuyor !'),
                )
              : s.postList.length < 1
                  ? Functions.loadingView()
                  : Column(
                      children: [
                        _search(),
                        _isSearch ? _listView(s) : _searchListView(s)
                      ],
                    );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
        onPressed: () {
          authController.isLogin.value
              ? Get.to(
                  AddPostPage(),
                )
              : Get.defaultDialog(middleText: 'Gönderi ekleyebilmeniz için giriş yapmanız gerekiyor',
                  title: 'Gönderi ekle',
                  cancel: TextButton(
                    child: Text('Tamam'),
                    onPressed: () => Get.back(),
                  ),
                  confirm: TextButton(style: ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text('Giriş Yap',style: TextStyle(color: Colors.white),),
                    onPressed: () => Get.to(LoginPage()),
                  ),
                );
        },
      ),
    );
  }

  Widget _search() {
    return Card(
      shadowColor: Colors.black,
      shape: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.grey[700]),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(38),
          topLeft: Radius.circular(38),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          autofocus: false,
          controller: _searchEdit,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Gönderi Ara...",
            hintStyle: TextStyle(color: Colors.grey[300]),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _listView(PostController s) {
    return Expanded(
      child: ListView.builder(
          itemCount: s.postList.length,
          itemBuilder: (context, int index) {
            Widget cesit;
            Widget icon;
            switch (s.postList[index].type) {
              case 'Soru':
                cesit = Text(
                  s.postList[index].type,
                  style: TextStyle(
                    color: Colors.yellow[900].withOpacity(.7),
                  ),
                );
                icon = Icon(
                  FlutterIcons.question_ant,
                  size: 50,
                );
                break;
              case 'Haber':
                cesit = Text(
                  s.postList[index].type,
                  style: TextStyle(
                    color: Colors.blue.withOpacity(.7),
                  ),
                );
                icon = Icon(FlutterIcons.news_ent);

                break;
              case 'Kütüphane':
                cesit = Text(
                  s.postList[index].type,
                  style: TextStyle(
                    color: Colors.blue.withOpacity(.7),
                  ),
                );
                icon = Icon(FlutterIcons.library_mco);

                break;
              case 'Eklenti':
                cesit = Text(
                  s.postList[index].type,
                  style: TextStyle(
                    color: Colors.blue.withOpacity(.7),
                  ),
                );
                icon = Icon(FlutterIcons.extension_mdi);

                break;
              default:
                cesit = Text(
                  s.postList[index].type,
                  style: TextStyle(
                    color: Color(
                      (Random().nextDouble() * 0xFFFFFF).toInt(),
                    ).withOpacity(1.0),
                  ),
                );
            }
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailPage(
                      s.postList[index],
                    ),
                  ),
                );
              },
              child: FadedScaleAnimation(
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 3, color: Colors.black),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                  ),
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
                                  backgroundColor: Colors.white,
                                  child: icon,
                                ),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          s.postList[index].heading,
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
                                        s.postList[index].content,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ]),
                              )
                            ]),
                          ),
                          GestureDetector(
                            onTap: () => favoriteController.favWidget(
                                type: FavType.Post, id: s.postList[index].id),
                            child: Obx(
                              () => AnimatedContainer(
                                  height: 35,
                                  padding: EdgeInsets.all(5),
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: (favoriteController.isFavPostList[
                                                  s.postList[index].id]) &&
                                              favoriteController.isFavPostList[
                                                      s.postList[index].id] !=
                                                  null
                                          ? Colors.red.shade100
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Center(
                                      child: (favoriteController.isFavPostList[
                                                  s.postList[index].id]) &&
                                              favoriteController.isFavPostList[
                                                      s.postList[index].id] !=
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        s.postList[index].userName,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(CupertinoIcons.profile_circled),
                                    ],
                                  ),
                                ),
                                Text(
                                  Functions.convertToAgo(
                                      s.postList[index].createdAt),
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _searchListView(PostController s) {
    _list = <Post>[];
    for (int i = 0; i < s.postList.length; i++) {
      _list.add(s.postList[i]);
    }

    _searchList = <Post>[];
    for (int i = 0; i < _list.length; i++) {
      var item = _list[i];

      if (item.heading.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchList.add(item);
      }
    }
    return _searchAddList(s);
  }

  Widget _searchAddList(PostController s) {
    return Expanded(
      child: ListView.builder(
          itemCount: _searchList.length,
          itemBuilder: (context, int index) {
            Widget cesit;
            Widget icon;
            switch (_searchList[index].type) {
              case 'Soru':
                cesit = Text(
                  _searchList[index].type,
                  style: TextStyle(
                    color: Colors.yellow[900].withOpacity(.7),
                  ),
                );
                icon = Icon(
                  FlutterIcons.question_ant,
                  size: 50,
                );
                break;
              case 'Haber':
                cesit = Text(
                  _searchList[index].type,
                  style: TextStyle(
                    color: Colors.blue.withOpacity(.7),
                  ),
                );
                icon = Icon(FlutterIcons.news_ent);

                break;
              case 'Kütüphane':
                cesit = Text(
                  _searchList[index].type,
                  style: TextStyle(
                    color: Colors.blue.withOpacity(.7),
                  ),
                );
                icon = Icon(FlutterIcons.library_mco);

                break;
              case 'Eklenti':
                cesit = Text(
                  _searchList[index].type,
                  style: TextStyle(
                    color: Colors.blue.withOpacity(.7),
                  ),
                );
                icon = Icon(FlutterIcons.extension_mdi);

                break;
              default:
                cesit = Text(
                  _searchList[index].type,
                  style: TextStyle(
                    color: Color(
                      (Random().nextDouble() * 0xFFFFFF).toInt(),
                    ).withOpacity(1.0),
                  ),
                );
            }
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailPage(
                      _searchList[index],
                    ),
                  ),
                );
              },
              child: FadedScaleAnimation(
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 3, color: Colors.black),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                  ),
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
                                  backgroundColor: Colors.white,
                                  child: icon,
                                ),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          _searchList[index].heading,
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
                                        _searchList[index].content,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ]),
                              )
                            ]),
                          ),
                          GestureDetector(
                            onTap: () => favoriteController.favWidget(
                                type: FavType.Post, id: _searchList[index].id),
                            child: Obx(
                              () => AnimatedContainer(
                                  height: 35,
                                  padding: EdgeInsets.all(5),
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: (favoriteController.isFavPostList[
                                                  _searchList[index].id]) &&
                                              favoriteController.isFavPostList[
                                                      _searchList[index].id] !=
                                                  null
                                          ? Colors.red.shade100
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Center(
                                      child: (favoriteController.isFavPostList[
                                                  _searchList[index].id]) &&
                                              favoriteController.isFavPostList[
                                                      _searchList[index].id] !=
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        _searchList[index].userName,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(CupertinoIcons.profile_circled),
                                    ],
                                  ),
                                ),
                                Text(
                                  Functions.convertToAgo(
                                      _searchList[index].createdAt),
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
