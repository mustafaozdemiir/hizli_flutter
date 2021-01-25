import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hizliflutter/models/news.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hizliflutter/services/youtube_full_screen.dart';

class NewsDetailPage extends StatefulWidget {
  News model;

  NewsDetailPage(this.model);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState(model);
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  News model;

  _NewsDetailPageState(this.model);

  YoutubePlayerController _controller;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;

  @override
  void initState() {
    if (model.youtubeVideoUrl != "yok") {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(model.youtubeVideoUrl),
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
        ),
      )..addListener(listener);
    }
    super.initState();
  }

  void listener() {
    if (!_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              snap: false,
              pinned: true,
              floating: true,
              title: Text(
                model.baslik,
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: model.resimler[0],
                  placeholder: (context, url) => Image.asset('res/loading.gif'),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    semanticLabel: "Resim Kaldırılmış",
                    size: 50,
                  ),
                ),
              ),
            ),
            model.youtubeVideoUrl == "yok"
                ? SliverToBoxAdapter(
                    child: SizedBox(
                      height: 0,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(model.uzunAciklama),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: YoutubePlayerBuilder(
                          onEnterFullScreen: () =>
                              SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeRight,
                            DeviceOrientation.landscapeLeft
                          ]).whenComplete(
                            () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => YoutubeFullScreen(model),
                              ),
                            ),
                          ),
                          builder: (context, player) {
                            return Column(
                              children: <Widget>[
                                player,
                              ],
                            );
                          },
                          player: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.amber,
                            progressColors: ProgressBarColors(
                                playedColor: Colors.amber,
                                handleColor: Colors.amberAccent),
                          ),
                        ),
                      ),
                    ]),
                  ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: model.resimler[index],
                        placeholder: (context, url) =>
                            Image.asset('res/loading.gif'),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          semanticLabel: "Resim Kaldırılmış",
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                childCount: model.resimler.length,
              ),
            ),
            SliverToBoxAdapter(
              child: RaisedButton(
                color: Colors.white,
                child: Text("KAYNAK"),
                onPressed: () {
                  launch(model.kaynakLink);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}