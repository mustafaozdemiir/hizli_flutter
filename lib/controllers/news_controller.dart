import 'dart:async';

import 'package:get/get.dart';
import 'package:hizliflutter/data/data.dart';
import '/models/news.dart';

import 'favorite_controller.dart';

class NewsController extends GetxController {
  FavoriteController fetchController = Get.put(FavoriteController());
  List<News> newsList;

  Future<void> getNewsApi() async {

        var parsedJson;
        newsList = <News>[].obs;
        parsedJson = await Data.get(isSecure: false, dataType: DataType.News);

        for (var model in parsedJson) {
          newsList.add(
            News.fromJson(model),
          );
          bool isFavWidget = false;
          await fetchController
              .isFav(type: FavType.News, id: News.fromJson(model).id)
              .then((value) {
            isFavWidget = value;
          });
          fetchController.isFavNewsList[News.fromJson(model).id] = isFavWidget;
        }
        newsList = newsList.reversed.toList();

    update();
  }
}
