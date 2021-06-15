import 'package:flutter/material.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/kodlar//ornek_alt_yonlerdirme_cubuk.dart';
import 'package:hizliflutter/kodlar/ornek_animated_text.dart';
import 'package:hizliflutter/kodlar/ornek_appbar.dart';
import 'package:hizliflutter/kodlar/ornek_avatar_glow.dart';
import 'package:hizliflutter/kodlar/ornek_giris_ekrani.dart';
import 'package:hizliflutter/kodlar/ornek_hesap_makinesi.dart';
import 'package:hizliflutter/kodlar/ornek_sayfa_gecis.dart';
import 'package:hizliflutter/kodlar//ornek_slidable_list.dart';
import 'package:hizliflutter/kodlar/ornek_slider_button.dart';
import 'package:hizliflutter/kodlar/ornek_swiper.dart';
import 'package:hizliflutter/kodlar/ornek_ust_yonlendirme_cubuk.dart';
import 'package:hizliflutter/models/sample.dart';
import 'sample_detail_page.dart';

class Samples extends StatefulWidget {
  @override
  _SamplesState createState() => _SamplesState();
}

class _SamplesState extends State<Samples> {
  List<Sample> ornekler = [
    Sample(
        adi: 'Giriş Ekranı',
        ornek: GirisEkrani(),
        kod: 'lib/kodlar/ornek_giris_ekrani.dart',
        kaynak: 'https://github.com/ahmed-alzahrani/Flutter_Simple_Login',
        zorluk: 'basit'),
    Sample(
        adi: 'Hesap Makinesi',
        ornek: HesapMakinesi(),
        kod: 'lib/kodlar/ornek_hesap_makinesi.dart',
        kaynak: 'https://github.com/emilsharier/Calculator',
        zorluk: 'orta'),
    Sample(
        adi: 'Sayfalar Arası Geçiş',
        ornek: SayfaGecis(),
        kod: 'lib/kodlar/ornek_sayfa_gecis.dart',
        kaynak:
            'https://flutter.dev/docs/cookbook/navigation/navigation-basics',
        zorluk: 'basit'),
    Sample(
        adi: 'Alt Yönlendirme Çubuğu',
        ornek: AltYonlendirmeCubugu(),
        kod: 'lib/kodlar/ornek_alt_yonlerdirme_cubuk.dart',
        kaynak: 'https://codesundar.com/flutter-bottom-navigation-tutorial/',
        zorluk: 'basit'),
    Sample(
        adi: 'Üst Çubuk',
        ornek: AppBarOrnek(),
        kod: 'lib/kodlar/ornek_appbar.dart',
        kaynak: 'https://www.yazilimmotoru.com/',
        zorluk: 'basit'),
    Sample(
        adi: 'Üst Yönlendirme Çubuğu',
        ornek: UstYonlendirmeCubugu(),
        kod: 'lib/kodlar/ornek_ust_yonlendirme_cubuk.dart',
        kaynak: 'https://www.yazilimmotoru.com/',
        zorluk: 'basit'),
    Sample(
        adi: 'Slider Button',
        ornek: SliderButtonOrnek(),
        kod: 'lib/kodlar/ornek_slider_button.dart',
        kaynak: 'https://www.yazilimmotoru.com/',
        zorluk: 'basit'),
    Sample(
        adi: 'Slidable List Item',
        ornek: SlidableList(),
        kod: 'lib/kodlar/ornek_slidable_list.dart',
        kaynak: 'https://www.yazilimmotoru.com/',
        zorluk: 'orta'),
    Sample(
        adi: 'Avatar Glow',
        ornek: AvatarGlowOrnek(),
        kod: 'lib/kodlar/ornek_avatar_glow.dart',
        kaynak: 'https://www.yazilimmotoru.com/',
        zorluk: 'basit'),
    Sample(
        adi: 'Swiper',
        ornek: SwiperOrnek(),
        kod: 'lib/kodlar/ornek_swiper.dart',
        kaynak: 'https://www.yazilimmotoru.com/',
        zorluk: 'orta'),
    Sample(
        adi: 'Text Animation Kit',
        ornek: OrnekAnimatedTextKit(),
        kod: 'lib/kodlar/ornek_animated_text.dart',
        kaynak: 'https://www.yazilimmotoru.com/',
        zorluk: 'orta'),
  ];

  @override
  Widget build(BuildContext context) {
    String bannerMessage;
    Color bannerColor;
    Color bannerTextColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.examples),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: ornekler.length,
          itemBuilder: (context, index) {
            switch (ornekler[index].zorluk) {
              case 'basit':
                bannerMessage = AppString.easy;
                bannerColor = Colors.green.withOpacity(.4);
                bannerTextColor = Colors.white;
                break;
              case 'orta':
                bannerMessage = AppString.middle;
                bannerColor = Colors.yellow.withOpacity(.7);
                bannerTextColor = Colors.black;
                break;
              case 'zor':
                bannerMessage = AppString.hard;
                bannerColor = Colors.red.withOpacity(.5);
                bannerTextColor = Colors.white;
                break;
            }
            return Banner(
              location: BannerLocation.topStart,
              message: bannerMessage,
              color: bannerColor,
              textStyle: TextStyle(color: bannerTextColor),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                ),
                child: ListTile(
                  title: Center(child: Text(ornekler[index].adi)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SampleDetailPage(ornekler[index]),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
