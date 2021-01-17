import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class AvatarGlowOrnek extends StatefulWidget {
  @override
  _AvatarGlowOrnekState createState() => _AvatarGlowOrnekState();
}

class _AvatarGlowOrnekState extends State<AvatarGlowOrnek> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AvatarGlow(
        child: Icon(Icons.gps_fixed,size: 70,color: Colors.green,),
        endRadius: 100,
        repeat: true,
        glowColor: Colors.red,
      ),
    );
  }
}
