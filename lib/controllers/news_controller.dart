import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import '../app_string.dart';
import '/models/news.dart';
import 'package:http/http.dart' as http;

import 'favorite_controller.dart';

class NewsController extends GetxController {
  FavoriteController fetchController = Get.put(FavoriteController());
  List<News> newsList;

  Future<void> getNewsApi() async {
    try {
      final http.Response response = await http.get(
        Uri.parse(AppString.webUrl + AppString.webDataUrl + 'news'),
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        newsList = <News>[].obs;
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
      } else {
        print('Hata var:' + response.body.toString());
      }
    } on TimeoutException catch (_) {}

    update();
  }
}
