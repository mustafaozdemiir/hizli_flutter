import 'package:flutter/material.dart';

class Sample {
  String _adi;
  String _zorluk;
  String _kod;
  Widget _ornek;
  String _kaynak;

  Sample({
    required String adi,
    required String zorluk,
    required String kod,
    required Widget ornek,
    required String kaynak,
  })  : _adi = adi,
        _zorluk = zorluk,
        _kod = kod,
        _ornek = ornek,
        _kaynak = kaynak;

  String get adi => _adi;
  set adi(String value) => _adi = value;

  String get zorluk => _zorluk;
  set zorluk(String value) => _zorluk = value;

  String get kod => _kod;
  set kod(String value) => _kod = value;

  Widget get ornek => _ornek;
  set ornek(Widget value) => _ornek = value;

  String get kaynak => _kaynak;
  set kaynak(String value) => _kaynak = value;
}
