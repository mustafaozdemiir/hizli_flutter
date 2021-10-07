import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum FavType {
  Widget,
  News,
  Sample,
  Post,
}

class FavoriteController extends GetxController {
  Map<int, bool> isFavWidgetList = <int, bool>{}.obs;

  Map<int, bool> isFavNewsList = <int, bool>{}.obs;

  Map<int, bool> isFavPostList = <int, bool>{}.obs;

  Map<int, bool> isFavSampleList = <int, bool>{}.obs;

  Future<bool> isFav({FavType type, int id}) async {
    String favType = '';
    switch (type) {
      case FavType.Widget:
        favType = 'widgetId';
        break;
      case FavType.News:
        favType = 'newsId';
        break;
      case FavType.Sample:
        favType = 'sampleId';
        break;
      case FavType.Post:
        favType = 'postId';
        break;
    }
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.containsKey(favType + id.toString())) {
      return true;
    } else {
      return false;
    }
  }

  favWidget({FavType type, int id}) async {
    String favType = '';
    switch (type) {
      case FavType.Widget:
        favType = 'widgetId';
        break;
      case FavType.News:
        favType = 'newsId';
        break;
      case FavType.Sample:
        favType = 'sampleId';
        break;
      case FavType.Post:
        favType = 'postId';
        break;
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey(favType + id.toString())) {
      pref.remove(favType + id.toString());
      switch (type) {
        case FavType.Widget:
          isFavWidgetList[id] = false;
          break;
        case FavType.News:
          isFavNewsList[id] = false;
          break;
        case FavType.Sample:
          isFavSampleList[id] = false;
          break;
        case FavType.Post:
          isFavPostList[id] = false;
          break;
      }
    } else {
      pref.setString(favType + id.toString(), 'true');
      switch (type) {
        case FavType.Widget:
          isFavWidgetList[id] = true;
          break;
        case FavType.News:
          isFavNewsList[id] = true;
          break;
        case FavType.Sample:
          isFavSampleList[id] = true;
          break;
        case FavType.Post:
          isFavPostList[id] = true;
          break;
      }
    }
    pref.reload();
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
