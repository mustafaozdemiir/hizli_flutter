import 'dart:async';
import 'package:get/get.dart';
import 'package:hizliflutter/data/data.dart';
import '/models/widget_model.dart';
import 'favorite_controller.dart';

class WidgetModelController extends GetxController {
  List<WidgetModel> widgetList;
  FavoriteController fetchController = Get.put(FavoriteController());

  @override
  void dispose() {
    super.dispose();
    fetchController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getWidgetsApi() async {
    var parsedJson;

    parsedJson = await Data.get(isSecure: false, dataType: DataType.Widget);
    widgetList = <WidgetModel>[].obs;

    if (parsedJson.toString() != '[]') {
      for (var model in parsedJson) {
        widgetList.add(
          WidgetModel.fromJson(model),
        );
        bool isFavWidget = false;
        await fetchController
            .isFav(type: FavType.Widget, id: WidgetModel.fromJson(model).id)
            .then((value) {
          isFavWidget = value;
        });
        fetchController.isFavWidgetList[WidgetModel.fromJson(model).id] =
            isFavWidget;
      }
      widgetList = widgetList.reversed.toList();
    }
    update();
  }
}
