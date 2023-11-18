import 'package:flutter/material.dart';
import 'dart:io';
import '../save_file.dart';


class SavedItemDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SavedItem savedItem = ModalRoute.of(context)!.settings.arguments as SavedItem;
    return Scaffold(
      appBar: AppBar(
        title: Text(savedItem.filename),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(File(savedItem.imagePath)),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Poem: ${savedItem.poemText}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
