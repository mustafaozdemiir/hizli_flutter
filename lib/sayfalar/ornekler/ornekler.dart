import 'package:flutter/material.dart';
import 'package:hizliflutter/kodlar/ornek_alt_yonlerdirme_cubuk.dart';
import 'package:hizliflutter/kodlar/ornek_appbar.dart';
import 'package:hizliflutter/kodlar/ornek_giris_ekrani.dart';
import 'package:hizliflutter/kodlar/ornek_hesap_makinesi.dart';
import 'package:hizliflutter/kodlar/ornek_sayfa_gecis.dart';
import 'package:hizliflutter/kodlar/ornek_ust_yonlendirme_cubuk.dart';
import 'package:hizliflutter/modeller/ornek.dart';
import 'ornek_detay.dart';

class Ornekler extends StatefulWidget {
  @override
  _OrneklerState createState() => _OrneklerState();
}

class _OrneklerState extends State<Ornekler> {
  List<Ornek> ornekler = [
    Ornek(
        adi: 'Giriş Ekranı',
        ornek: GirisEkrani(),
        kod: 'lib/kodlar/ornek_giris_ekrani.dart',
        kaynak: 'https://github.com/ahmed-alzahrani/Flutter_Simple_Login',
        zorluk: 'basit'),
    Ornek(
        adi: 'Hesap Makinesi',
        ornek: HesapMakinesi(),
        kod: 'lib/kodlar/ornek_hesap_makinesi.dart',
        kaynak: 'https://github.com/emilsharier/Calculator',
        zorluk: 'orta'),
    Ornek(
        adi: 'Sayfalar Arası Geçiş',
        ornek: SayfaGecis(),
        kod: 'lib/kodlar/ornek_sayfa_gecis.dart',
        kaynak:
            'https://flutter.dev/docs/cookbook/navigation/navigation-basics',
        zorluk: 'basit'),
    Ornek(
        adi: 'Alt Yönlendirme Çubuğu',
        ornek: AltYonlendirmeCubugu(),
        kod: 'lib/kodlar/ornek_alt_yonlerdirme_cubuk.dart',
        kaynak: 'https://codesundar.com/flutter-bottom-navigation-tutorial/',
        zorluk: 'basit'),
    Ornek(
        adi: 'Üst Çubuk',
        ornek: AppBarOrnek(),
        kod: 'lib/kodlar/ornek_appbar.dart',
        kaynak: 'https://www.yazilimmotoru.com/',
        zorluk: 'basit'),
    Ornek(
        adi: 'Üst Yönlendirme Çubuğu',
        ornek: UstYonlendirmeCubugu(),
        kod: 'lib/kodlar/ornek_ust_yonlendirme_cubuk.dart',
        kaynak: 'https://www.yazilimmotoru.com/',
        zorluk: 'basit'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Örnek Uygulamalar'),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: ornekler.length,
          itemBuilder: (context, index) {
            Icon zorlukIcon;
            switch (ornekler[index].zorluk) {
              case 'basit':
                zorlukIcon = Icon(
                  Icons.thumb_up,
                  color: Colors.green,
                );
                break;
              case 'orta':
                zorlukIcon = Icon(
                  Icons.thumbs_up_down,
                  color: Colors.yellow,
                );
                break;
              case 'zor':
                zorlukIcon = Icon(
                  Icons.thumb_down,
                  color: Colors.red,
                );
                break;
            }
            return Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 3, color: Colors.lightBlue),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: ListTile(
                leading: zorlukIcon,
                title: Center(child: Text(ornekler[index].adi)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrnekDetay(ornekler[index]),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
