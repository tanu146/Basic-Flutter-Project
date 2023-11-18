import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class SavedItem {
  final String poemText;
  final String imagePath;
  final String filename;

  SavedItem({
    required this.poemText,
    required this.imagePath,
    required this.filename,
  });
}

class SavedItemsProvider extends ChangeNotifier {
  List<SavedItem> _savedItems = [];

  List<SavedItem> get savedItems => _savedItems;

  void addSavedItem(SavedItem item) {
    _savedItems.add(item);
    notifyListeners();
  }


}

class SavedItemsScreen extends StatelessWidget {

  void _shareSavedItem(SavedItem savedItem) async {
    String shareMessage = savedItem.poemText;

    if (savedItem.imagePath != null && savedItem.imagePath.isNotEmpty) {
      await Share.shareFiles([savedItem.imagePath], text: shareMessage);
    } else {
      await Share.share(shareMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedItemsProvider = Provider.of<SavedItemsProvider>(context);
    final savedItems = savedItemsProvider.savedItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Items'),
      ),
      body: ListView.builder(
        itemCount: savedItems.length,
        itemBuilder: (context, index) {
          final savedItem = savedItemsProvider.savedItems[index];
          return ListTile(
            title: Text(savedItem.filename),
            trailing: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                _shareSavedItem(savedItem);
              },
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/savedItemDetails',
                arguments: savedItem,
              );
            },
          );
        },
      ),
    );
  }
}



