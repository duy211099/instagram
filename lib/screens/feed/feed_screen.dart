import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/screens.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('FeedScreen'),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Scaffold(body: Text('sadasdas')))),
        ),
      ),
    );
  }
}
