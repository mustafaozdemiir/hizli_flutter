import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class SlidableList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Arşivle',
                color: Colors.blue,
                icon: Icons.archive,
                onTap: () => Get.snackbar("Arşivle", "Arşivle"),
              ),
              IconSlideAction(
                caption: 'Paylaş',
                color: Colors.indigo,
                icon: Icons.share,
                onTap: () => Get.snackbar("Paylaş", "Paylaş"),
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Daha Fazla',
                color: Colors.grey.shade200,
                icon: Icons.more_horiz,
                onTap: () => Get.snackbar("Daha Fazla", "Daha Fazla"),
                closeOnTap: false,
              ),
              IconSlideAction(
                caption: 'Sil',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => Get.snackbar("Sil", "Sil"),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(tileColor: Colors.grey.shade400,
                    title: Text("Başlık "+index.toString()),
                    subtitle: Text("Sağ veya sola kaydır "+index.toString()),
                  ),
            ),
          )),
    );
  }
}
