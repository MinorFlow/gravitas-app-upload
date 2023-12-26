import 'package:flutter/material.dart';

class EmptyCover extends StatefulWidget {
  const EmptyCover({super.key, this.str});
  final String? str;

  @override
  State<EmptyCover> createState() => _EmptyCoverState();
}

class _EmptyCoverState extends State<EmptyCover> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sentiment_satisfied_outlined, size: 64, color: Colors.black12,),
          const SizedBox(height: 8,),
          Text(widget.str ?? '아무것도 없어요!', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black12))
        ],
      ),
    );
  }
}