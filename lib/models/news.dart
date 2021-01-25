import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String _baslik;
  String _kisaAciklama;
  String _uzunAciklama;
  String _turu;
  String _cesidi;
  String _youtubeVideoUrl;
  String _kaynakLink;
  Timestamp _yayinTarihi;
  List<String> _resimler;
  String _baslikResim;

  News(
      {String baslik,
      String kisaAciklama,
      String uzunAciklama,
      String turu,
      String cesidi,
      String youtubeVideoUrl,
      String kaynakLink,
      List<String> resimler,
      Timestamp yayinTarihi,
      String baslikResim}) {
    this._baslik = baslik;
    this._kisaAciklama = kisaAciklama;
    this._uzunAciklama = uzunAciklama;
    this._turu = turu;
    this._cesidi = cesidi;
    this._youtubeVideoUrl = youtubeVideoUrl;
    this._kaynakLink = kaynakLink;
    this._resimler = resimler;
    this._yayinTarihi = yayinTarihi;
    this._baslikResim = baslikResim;
  }

  String get baslik => _baslik;

  set baslik(String value) {
    _baslik = value;
  }

  String get kisaAciklama => _kisaAciklama;

  List<String> get resimler => _resimler;

  set resimler(List<String> value) {
    _resimler = value;
  }

  String get kaynakLink => _kaynakLink;

  set kaynakLink(String value) {
    _kaynakLink = value;
  }

  String get youtubeVideoUrl => _youtubeVideoUrl;

  set youtubeVideoUrl(String value) {
    _youtubeVideoUrl = value;
  }

  String get uzunAciklama => _uzunAciklama;

  set uzunAciklama(String value) {
    _uzunAciklama = value;
  }

  set kisaAciklama(String value) {
    _kisaAciklama = value;
  }

  String get cesidi => _cesidi;

  set cesidi(String value) {
    _cesidi = value;
  }

  String get turu => _turu;

  set turu(String value) {
    _turu = value;
  }

  Timestamp get yayinTarihi => _yayinTarihi;

  set yayinTarihi(Timestamp value) {
    _yayinTarihi = value;
  }

  String get baslikResim => _baslikResim;

  set baslikResim(String value) {
    _baslikResim = value;
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        baslik: json['baslik'].toString().replaceAll("/n", "\n"),
        kisaAciklama: json['kisaAciklama'],
        uzunAciklama: json['uzunAciklama'],
        turu: json['turu'],
        cesidi: json['cesidi'],
        youtubeVideoUrl: json['youtubeVideoUrl'],
        kaynakLink: json['kaynakLink'],
        yayinTarihi: json['yayinTarihi'],
        baslikResim: json['baslikResim'],
        resimler: List<String>.from(json['resimler']));
  }
}
