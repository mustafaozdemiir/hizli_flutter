import 'package:flutter/material.dart';

class Sample {
  String _adi;
  String _zorluk;
  String _kod;
  Widget _ornek;
  String _kaynak;

  Sample({String adi, String zorluk, String kod, Widget ornek,String kaynak}) {
    this._adi = adi;
    this._zorluk=zorluk;
    this._kod=kod;
    this._ornek=ornek;
    this._kaynak=kaynak;
  }

  String get adi => _adi;

  set adi(String value) {
    _adi = value;
  }

  Widget get ornek => _ornek;

  set ornek(Widget value) {
    _ornek = value;
  }

  String get kod => _kod;

  set kod(String value) {
    _kod = value;
  }

  String get zorluk => _zorluk;

  set zorluk(String value) {
    _zorluk = value;
  }

  String get kaynak => _kaynak;

  set kaynak(String value) {
    _kaynak = value;
  }


}
