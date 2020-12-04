class WidgetMetod {
  String _adi;
  String _aciklama;
  String _turu;

  WidgetMetod({String adi, String aciklama, String turu}) {
    this._adi = adi;
    this._aciklama = aciklama;
    this._turu = turu;
  }

  String get adi => _adi;

  set adi(String value) {
    _adi = value;
  }

  String get turu => _turu;

  set turu(String value) {
    _turu = value;
  }

  String get aciklama => _aciklama;

  set aciklama(String value) {
    _aciklama = value;
  }

  factory WidgetMetod.fromJson(Map<String, dynamic> json) => WidgetMetod(
        adi: json['adi'],
        aciklama: json['aciklama'],
        turu: json['turu'],
      );
}

class WidgetModel {
  String _adi;
  String _kisaAciklama;
  String _uzunAciklama;
  List<WidgetMetod> _metodlar;
  String _kodDizin;
  String _kodTuru;
  String _cesit;

  WidgetModel({
    String adi,
    String kisaAciklama,
    String uzunAciklama,
    List<WidgetMetod> metodlar,
    String kodDizin,
    String kodTuru,
    String cesit,
  }) {
    this._adi = adi;
    this._kisaAciklama = kisaAciklama;
    this._uzunAciklama = uzunAciklama;
    this._metodlar = metodlar;
    this._kodDizin = kodDizin;
    this._kodTuru = kodTuru;
    this._cesit = cesit;
  }

  String get adi => _adi;

  set adi(String value) {
    _adi = value;
  }

  String get kisaAciklama => _kisaAciklama;

  set kisaAciklama(String value) {
    _kisaAciklama = value;
  }

  String get uzunAciklama => _uzunAciklama;

  set uzunAciklama(String value) {
    _uzunAciklama = value;
  }

  List<WidgetMetod> get metodlar => _metodlar;

  set metodlar(List<WidgetMetod> value) {
    _metodlar = value;
  }

  String get kodDizin => _kodDizin;

  set kodDizin(String value) {
    _kodDizin = value;
  }

  String get kodTuru => _kodTuru;

  set kodTuru(String value) {
    _kodTuru = value;
  }

  String get cesit => _cesit;

  set cesit(String value) {
    _cesit = value;
  }

  factory WidgetModel.fromJson(Map<String, dynamic> json) {
    var list = json['metodlar'] as List;
    List<WidgetMetod> metodList = list.map((e) => WidgetMetod.fromJson(e)).toList();
    return WidgetModel(
        adi: json['adi'].toString().replaceAll("/n", "\n"),
        kisaAciklama: json['kisaAciklama'],
        uzunAciklama: json['uzunAciklama'],
        kodDizin: json['kodDizin'],
        kodTuru: json['kodTuru'],
        cesit: json['cesit'],
        metodlar: metodList);
  }
}
