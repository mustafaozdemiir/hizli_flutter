import 'package:hizliflutter/models/main_model.dart';

class News extends MainModel {
  final int id;
  final String heading;
  final String subTitle;
  final String title;
  final String type;
  final String kind;
  final String youtubeVideoUrl;
  final String sourceLink;
  final DateTime releaseDate;
  final List<String> pictures;
  final String titlePicture;
  final DateTime createdAt;
  final DateTime updatedAt;

  News({
    required this.id,
    required this.heading,
    required this.subTitle,
    required this.title,
    required this.type,
    required this.kind,
    required this.youtubeVideoUrl,
    required this.sourceLink,
    required this.releaseDate,
    required this.titlePicture,
    required this.pictures,
    required this.createdAt,
    required this.updatedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    List<String> picturess = [];
    var photos = (json['pictures'] ?? '').toString().split(',');
    for (var photo in photos) {
      if (photo.isNotEmpty) {
        picturess.add(photo);
      }
    }
    return News(
      id: (json['id'] is int)
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      heading: json['heading']?.toString().replaceAll("/n", "\n") ?? '',
      subTitle: json['subTitle']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      kind: json['kind']?.toString() ?? '',
      youtubeVideoUrl: json['youtubeVideoUrl']?.toString() ?? '',
      sourceLink: json['sourceLink']?.toString() ?? '',
      releaseDate: DateTime.tryParse(json['releaseDate']?.toString() ?? '') ??
          DateTime.now(),
      titlePicture: json['titlePicture']?.toString() ?? '',
      pictures: picturess,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'heading': heading,
        'subTitle': subTitle,
        'title': title,
        'type': type,
        'kind': kind,
        'youtubeVideoUrl': youtubeVideoUrl,
        'sourceLink': sourceLink,
        'pictures': pictures,
        'releaseDate': releaseDate.toIso8601String(),
        'titlePicture': titlePicture,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
