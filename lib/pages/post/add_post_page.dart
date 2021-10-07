import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/controllers/post_controller.dart';


class AddPostPage extends StatelessWidget {
  PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Yeni Gönderi Ekle'),
      ),
      body: addPostView(),
    );
  }
  addPostView() {
    return Container(
      height: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white38,
        shape: RoundedRectangleBorder(side: BorderSide.none),
      ),
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: postController.postFormKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              formFields(),
              addButton(),
            ],
          ),
        ),
      ),
    );
  }

  formFields() {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Boş olamaz!';
            }
            return null;
          },
          controller: postController.headingPostController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Başlık',
            labelText: 'Başlık',
            suffixIcon: Icon(FlutterIcons.format_title_mco),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLines: 10,
          validator: (value) {
            if (value.isEmpty) {
              return 'Boş olamaz!';
            }
            if (value.length < 30) {
              return 'En az 30 karakter girmelisiniz';
            }
            return null;
          },
          controller: postController.contentPostController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'İçerik',
            labelText: 'İçerik',
            suffixIcon: Icon(FlutterIcons.text_mco),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Obx(()=>DropdownButton<PostType>(underline: SizedBox(),
            focusColor: Colors.white,
            value: postController.typeController.value,
            //elevation: 5,
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: <PostType>[
              PostType.Question,
              PostType.News,
              PostType.Plugin,
              PostType.Library,
            ].map<DropdownMenuItem<PostType>>((PostType value) {
              String text = 'Soru';
              switch (value) {
                case PostType.Question:
                  text = 'Soru';
                  break;
                case PostType.News:
                  text = 'Haber';
                  break;
                case PostType.Library:
                  text = 'Kütüphane';
                  break;
                case PostType.Plugin:
                  text = 'Eklenti';
                  break;
              }
              return DropdownMenuItem<PostType>(
                value: value,
                child: Text(
                  text,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            hint: Text(
              "Gönderi Tipi",
              style: TextStyle(
                  color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            onChanged: (PostType value) {
                postController.typeController.value = value;
            },
          ),
        ),
      ],
    );
  }

  addButton() {
    return Obx(
          () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: postController.isLoading.value
            ? CircularProgressIndicator()
            : TextButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              Size(Get.width * 0.95, 50),
            ),
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.blueAccent),
          ),
          onPressed: postController.addPost,
          child: Text(
            'Ekle',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
