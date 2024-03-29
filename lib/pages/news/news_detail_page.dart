import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/models/news.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class NewsDetailPage extends StatefulWidget {
  News model;

  NewsDetailPage(this.model);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState(model);
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  News model;
  YoutubePlayerController _controller;

  _NewsDetailPageState(this.model);

  @override
  void initState() {
    buildPlayerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: buildScreen(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void buildPlayerController() {
    if (model.youtubeVideoUrl != "yok") {
      _controller = YoutubePlayerController(
        initialVideoId: model.youtubeVideoUrl,
        params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      );
    }
  }

  Widget buildScreen() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          snap: false,
          pinned: true,
          floating: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            model.heading,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,

        ),
        model.youtubeVideoUrl == "yok"
            ? SliverToBoxAdapter(
          child: SizedBox(
            height: 0,
          ),
        )
            : SliverList(
          delegate: SliverChildListDelegate(
            [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(model.title),
              ),
              GetPlatform.isWeb
                  ? Image.network(model.pictures[0])
                  : CachedNetworkImage(
                imageUrl: model.pictures[0],
                placeholder: (context, url) =>
                    Image.asset('res/loading.gif'),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  semanticLabel: AppString.imageRemoved,
                  size: 50,
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: Get.height * 0.4,
                  child: YoutubePlayerIFrame(
                    controller: _controller,
                    aspectRatio: 16 / 9,
                  ),
                ),
              )
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GetPlatform.isWeb
                      ? Image.network(model.pictures[index])
                      : CachedNetworkImage(
                    imageUrl: model.pictures[index],
                    placeholder: (context, url) =>
                        Image.asset('res/loading.gif'),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      semanticLabel: AppString.imageRemoved,
                      size: 50,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            childCount: model.pictures.length,
          ),
        ),
        SliverToBoxAdapter(
          child: RaisedButton(
            color: Colors.white,
            child: Text(AppString.source),
            onPressed: () {
              launch(model.sourceLink);
            },
          ),
        ),
      ],
    );
  }
}
