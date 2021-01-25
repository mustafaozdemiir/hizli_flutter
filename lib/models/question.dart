class Question {
  String _baslik;
  String _zorluk;
  String _cevap;
  List<String> _cevaplar;
  int _puan;
  int _zaman;

  Question(
      {String baslik,
      String zorluk,
      String cevap,
      List<String> cevaplar,
      int puan,
      int zaman}) {
    this._baslik = baslik;
    this.zorluk = zorluk;
    this._cevap = cevap;
    this._cevaplar = cevaplar;
    this._puan = puan;
    this._zaman = zaman;
  }

  int get zaman => _zaman;

  set zaman(int value) {
    _zaman = value;
  }

  int get puan => _puan;

  set puan(int value) {
    _puan = value;
  }

  List<String> get cevaplar => _cevaplar;

  set cevaplar(List<String> value) {
    _cevaplar = value;
  }

  String get cevap => _cevap;

  set cevap(String value) {
    _cevap = value;
  }

  String get zorluk => _zorluk;

  set zorluk(String value) {
    _zorluk = value;
  }

  String get baslik => _baslik;

  set baslik(String value) {
    _baslik = value;
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    var cevaplarList = List<String>.from(json['cevaplar']);
    cevaplarList.shuffle();
    return Question(
      baslik: json['baslik'].toString().replaceAll("/n", "\n"),
      zorluk: json['zorluk'],
      cevap: json['cevap'],
      puan: json['puan'],
      zaman: json['zaman'],
      cevaplar: cevaplarList,
    );
  }
}
