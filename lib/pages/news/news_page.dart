import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/controllers/fetch_controller.dart';
import 'news_detail_page.dart';

class NewsPage extends StatelessWidget {
  final FetchController fetchController = Get.put(FetchController());
  Widget zaman;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(AppString.news),
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<FetchController>(
        initState: (_) => Get.find<FetchController>().getNewsApi(),
        builder: (s) {
          return s.haberListe.length < 1
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[_listView(s)],
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget _listView(FetchController s) {
    String bannerMessage;
    Color bannerColor;
    Color bannerTextColor;
    return s.haberListe != null
        ? Expanded(
            child: ListView.builder(
                itemCount: s.haberListe.length,
                itemBuilder: (context, int index) {
                  if (DateTime.now()
                          .difference(s.haberListe[index].releaseDate)
                          .inDays ==
                      0) {
                    bannerMessage = AppString.recent;
                    bannerColor = Colors.yellow;
                    bannerTextColor = Colors.black;
                  } else {
                    if (DateTime.now()
                            .difference(s.haberListe[index].releaseDate)
                            .inDays <
                        365) {
                      bannerMessage = DateTime.now()
                              .difference(s.haberListe[index].releaseDate)
                              .inDays
                              .toString() +
                          ' ' +
                          AppString.dayAgo;
                      bannerColor = Colors.green;
                      bannerTextColor = Colors.white;
                    } else if (365 <=
                            DateTime.now()
                                .difference(s.haberListe[index].releaseDate)
                                .inDays &&
                        DateTime.now()
                                .difference(s.haberListe[index].releaseDate)
                                .inDays <=
                            730) {
                      bannerMessage = '1 ' + AppString.yearAgo;
                      bannerColor = Colors.purple;
                      bannerTextColor = Colors.white;
                    } else if (DateTime.now()
                            .difference(s.haberListe[index].releaseDate)
                            .inDays >
                        365) {
                      bannerMessage = '2 ' + AppString.yearAgo;
                      bannerColor = Colors.black;
                      bannerTextColor = Colors.white;
                    }
                  }
                  return Banner(
                    message: bannerMessage,
                    location: BannerLocation.bottomStart,
                    textStyle: TextStyle(color: bannerTextColor, fontSize: 10),
                    color: bannerColor,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 3, color: Colors.black),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        ),
                      ),
                      child: ListTile(
                        trailing: Container(
                          width: Get.width * 0.12,
                          child: IconButton(
                            onPressed: () => favWidget(),
                            icon: Icon(
                              FlutterIcons.favorite_border_mdi,
                              color: Colors.blue,
                              size: 35,
                            ),
                          ),
                        ),
                        leading: GetPlatform.isWeb
                            ? Image.network(s.haberListe[index].titlePicture)
                            : CachedNetworkImage(
                                width: Get.width * 0.2,
                                height: Get.height * 0.2,
                                imageUrl: s.haberListe[index].titlePicture,
                                placeholder: (context, url) =>
                                    Image.asset('res/loading.gif'),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  semanticLabel: AppString.imageRemoved,
                                  size: 50,
                                ),
                              ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailPage(s.haberListe[index]),
                            ),
                          );
                        },
                        title: Container(
                          width: Get.width * 0.5,
                          height: Get.height * 0.05,
                          child: Center(
                            child: Text(
                              s.haberListe[index].heading,
                              style: TextStyle(fontSize: 20),
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              s.haberListe[index].subTitle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        : CircularProgressIndicator();
  }

  favWidget() {}
}
