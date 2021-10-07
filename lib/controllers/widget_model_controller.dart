import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '/models/widget_model.dart';
import 'package:http/http.dart' as http;
import '../app_string.dart';
import 'favorite_controller.dart';

class WidgetModelController extends GetxController{
  List<WidgetModel> widgetList;
  FavoriteController fetchController = Get.put(FavoriteController());


  @override
  void dispose() {
    super.dispose();
    fetchController.dispose();
  }

  Future<void> getWidgetsApi() async {
    try {
      final http.Response response =
      await http.get(Uri.parse(AppString.webUrl + AppString.webDataUrl + 'widgets'));

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        widgetList = <WidgetModel>[].obs;
        for (var model in parsedJson) {
          widgetList.add(
            WidgetModel.fromJson(model),
          );
          bool isFavWidget = false;
          await fetchController.isFav(type: FavType.Widget, id: WidgetModel.fromJson(model).id)
              .then((value) {
            isFavWidget = value;
          });
          fetchController.isFavWidgetList[WidgetModel.fromJson(model).id] = isFavWidget;
        }
        widgetList = widgetList.reversed.toList();
      } else {
        print('Hata var');
      }
    } on TimeoutException catch (_) {}
    update();
  }
}