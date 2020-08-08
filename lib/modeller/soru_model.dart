class Soru {
  String _baslik;
  String _zorluk;
  String _cevap;
  List<String> _cevaplar;
  int _puan;
  int _zaman;

  Soru(
      {String baslik,
      String zorluk,
      String cevap,
      List<String> cevaplar,
      int puan,
      int zaman}) {
    this._baslik = baslik;
    this.zorluk=zorluk;
    this._cevap=cevap;
    this._cevaplar=cevaplar;
    this._puan=puan;
    this._zaman=zaman;
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
}
