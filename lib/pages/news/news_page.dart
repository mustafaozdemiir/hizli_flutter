import 'dart:math';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/controllers/auth/auth_controller.dart';
import 'package:hizliflutter/controllers/favorite_controller.dart';
import 'package:hizliflutter/controllers/news_controller.dart';
import 'package:hizliflutter/services/functions.dart';
import 'news_detail_page.dart';

class NewsPage extends StatelessWidget {
  final FavoriteController fetchController = Get.put(FavoriteController());
  final NewsController newsController = Get.put(NewsController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(AppString.news),
        actions: [
          Functions.loginLogoutButton(),
        ],
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<NewsController>(
        initState: (_) => newsController.getNewsApi(),
        builder: (s) {
          final hasNews = s.newsList != null && s.newsList!.isNotEmpty;
          if (hasNews) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [_listView(s)],
                ),
              ),
            );
          } else {
            return Functions.loadingView();
          }
        },
      ),
    );
  }

  Widget _listView(NewsController s) {
    return Expanded(
      child: ListView.builder(
        itemCount: s.newsList!.length,
        itemBuilder: (context, int index) {
          final newsItem = s.newsList![index];
          final cesit = _getCesit(newsItem.type);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(newsItem),
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
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  CupertinoIcons.news,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        newsItem.heading,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      newsItem.subTitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => fetchController.favWidget(
                            type: FavType.News,
                            id: newsItem.id,
                          ),
                          child: Obx(
                                () => AnimatedContainer(
                              height: 35,
                              padding: EdgeInsets.all(5),
                              duration: Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: fetchController.isFavNewsList[newsItem.id] != null &&
                                      fetchController.isFavNewsList[newsItem.id]!
                                      ? Colors.red.shade100
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  fetchController.isFavNewsList[newsItem.id] != null &&
                                      fetchController.isFavNewsList[newsItem.id]!
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: fetchController.isFavNewsList[newsItem.id] != null &&
                                      fetchController.isFavNewsList[newsItem.id]!
                                      ? Colors.red
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.shade200,
                                ),
                                child: cesit,
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                          Text(
                            Functions.convertToAgo(newsItem.createdAt),
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getCesit(String type) {
    switch (type) {
      case 'Haftanın Widget\' i':
        return Text(
          type,
          style: TextStyle(
            color: Colors.yellow[900]!.withOpacity(.7),
          ),
        );
      case 'Widget':
        return Text(
          type,
          style: TextStyle(
            color: Colors.blue.withOpacity(.7),
          ),
        );
      default:
        return Text(
          type,
          style: TextStyle(
            color: Color(
              (Random().nextDouble() * 0xFFFFFF).toInt(),
            ).withOpacity(1.0),
          ),
        );
    }
  }
}
