import 'package:flutter/material.dart';

class GroupCircleLink extends StatefulWidget {
  const GroupCircleLink({super.key});

  @override
  State<GroupCircleLink> createState() => _GroupCircleLinkState();
}

class _GroupCircleLinkState extends State<GroupCircleLink> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: 72,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xff4dabf7),
            Color(0xffda77f2),
            Color(0xfff783ac),
          ],
        ),
        borderRadius: BorderRadius.circular(500),
      ),
      child: const Icon(Icons.public, color: Colors.white, size: 56,),
    );
  }
}