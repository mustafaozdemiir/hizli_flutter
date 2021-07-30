class News {
  int _id;
  String _heading;
  String _subTitle;
  String _title;
  String _type;
  String _kind;
  String _youtubeVideoUrl;
  String _sourceLink;
  DateTime _releaseDate;
  List<String> _pictures;
  String _titlePicture;

  News(
      {int id,
        String heading,
      String subTitle,
      String title,
      String type,
      String kind,
      String youtubeVideoUrl,
      String sourceLink,
      List<String> pictures,
      DateTime releaseDate,
      String titlePicture}) {
    this._id=id;
    this._heading = heading;
    this._subTitle = subTitle;
    this._title = title;
    this._type = type;
    this._kind = kind;
    this._youtubeVideoUrl = youtubeVideoUrl;
    this._sourceLink = sourceLink;
    this._pictures = pictures;
    this._releaseDate = releaseDate;
    this._titlePicture = titlePicture;
  }


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get heading => _heading;

  set heading(String value) {
    _heading = value;
  }

  String get kind => _kind;

  set kind(String value) {
    _kind = value;
  }


  String get subTitle => _subTitle;

  List<String> get pictures => _pictures;

  set pictures(List<String> value) {
    _pictures = value;
  }

  String get sourceLink => _sourceLink;

  set sourceLink(String value) {
    _sourceLink = value;
  }

  String get youtubeVideoUrl => _youtubeVideoUrl;

  set youtubeVideoUrl(String value) {
    _youtubeVideoUrl = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  set subTitle(String value) {
    _subTitle = value;
  }

  String get kink => _kind;

  set kink(String value) {
    _kind = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  DateTime get releaseDate => _releaseDate;

  set releaseDate(DateTime value) {
    _releaseDate = value;
  }

  String get titlePicture => _titlePicture;

  set titlePicture(String value) {
    _titlePicture = value;
  }

  factory News.fromJson(Map<String, dynamic> json) {
    List<String> picturess = [];
    var photos = json['pictures'].toString().split(',');
    for (var photo in photos) {
      if (photo.isNotEmpty && photo != null) {
        picturess.add(photo);
      }
    }
    return News(
        id: int.parse(json['id']),
        heading: json['heading'].toString().replaceAll("/n", "\n"),
        subTitle: json['subTitle'],
        title: json['title'],
        type: json['type'],
        kind: json['kind'],
        youtubeVideoUrl: json['youtubeVideoUrl'],
        sourceLink: json['sourceLink'],
        releaseDate: DateTime.parse(json['releaseDate']),
        titlePicture: json['titlePicture'],
        pictures: picturess);
  }

}
