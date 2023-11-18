import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:io';
import 'package:PoetryPalette/save_file.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

List<SavedItem> savedItems = [];

class PoemScreen extends StatefulWidget {
  @override
  _PoemScreenState createState() => _PoemScreenState();
}

class FontPickerDialog extends StatelessWidget {
  final String selectedFont;
  final List<String> availableFonts;
  final Function(String) onFontChanged;

  FontPickerDialog({
    required this.selectedFont,
    required this.availableFonts,
    required this.onFontChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Choose a Font'),
      children: [
        for (String font in availableFonts)
          ListTile(
            title: Text(font),
            onTap: () => onFontChanged(font),
            selected: font == selectedFont,
          ),
      ],
    );
  }
}

class _PoemScreenState extends State<PoemScreen> {
  int savedItemsCounter = 1;
  TextEditingController _poemController = TextEditingController();
  Color _textColor = Colors.white;
  double _textSize = 22.0;
  FontWeight _fontWeight = FontWeight.normal;
  String _selectedFont = 'Roboto';
  List<String> availableFonts = [
    'Roboto', // Default font
    'Arial',
    'Courier New',
    'Open Sans',

  ];

  XFile _selectedImage = XFile('');

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 120.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  _handlePickedImage(pickedFile);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  _handlePickedImage(pickedFile);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _handlePickedImage(XFile? pickedFile) {
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }



  bool _showCustomizationOptions = false;

  void _toggleCustomizationOptions() {
    setState(() {
      _showCustomizationOptions = !_showCustomizationOptions;
    });
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _textColor,
              onColorChanged: (color) {
                setState(() {
                  _textColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void _toggleBold() {
    setState(() {
      _fontWeight =
      _fontWeight == FontWeight.bold ? FontWeight.normal : FontWeight.bold;
    });
  }


  void _showFontPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FontPickerDialog(
          selectedFont: _selectedFont,
          availableFonts: availableFonts,
          onFontChanged: (String font) {
            setState(() {
              _selectedFont = font;
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }



  Future<void> _savePoemAndImage() async {
    String poemText = _poemController.text;

    // Check if an image is selected
    if (_selectedImage != null) {
      String styledPoem = '$poemText';

      final savedItemsProvider =
      Provider.of<SavedItemsProvider>(context, listen: false);
      String imagePath = _selectedImage.path;

      String filename = 'file$savedItemsCounter';

      SavedItem savedItem =
      SavedItem(poemText: styledPoem, imagePath: _selectedImage.path,  filename: filename);
      savedItemsProvider.addSavedItem(savedItem);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Poem and image saved!'),
        ),
      );
      savedItemsCounter++;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image before saving.'),
        ),
      );
    }
  }

  void _sharePoemAndImage() async {
    String styledPoem = '${_poemController.text}';

    String shareMessage = 'Check out my poem:\n\n$styledPoem';

    if (_selectedImage != null && _selectedImage.path.isNotEmpty) {
      await Share.shareFiles([_selectedImage.path], text: shareMessage);
    } else {
      await Share.share(shareMessage);
    }
  }


  @override
  Widget build(BuildContext context) {
    ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
      primary: Colors.pink,
      onPrimary: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('PoetryPalette'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'viewSavedItems') {
                Navigator.pushNamed(context, '/savedItems');
              } else if (value == 'accountInfo') {
                Navigator.pushNamed(context, '/userProfile'); // Navigate to user profile
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'viewSavedItems',
                child: Text('View Saved Items'),
              ),
              PopupMenuItem<String>(
                value: 'accountInfo',
                child: Text('Account Information'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _selectImage,
              style: customButtonStyle,
              child: Row(
                children: [
                  Icon(
                    Icons.image,
                    size: 30,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text('Select Image', style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (_selectedImage != null &&
                        _selectedImage.path.isNotEmpty)
                      Image.file(
                        File(_selectedImage.path),
                        fit: BoxFit.contain,
                      ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _poemController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Write your poem here...',
                      ),
                      style: TextStyle(
                        color: _textColor,
                        fontSize: _textSize,
                        fontFamily: _selectedFont,
                        fontWeight: _fontWeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _toggleCustomizationOptions,
              style: customButtonStyle,
              child: Text('Customize', style: TextStyle(fontSize: 20),),
            ),
            Visibility(
              visible: _showCustomizationOptions,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _showColorPicker,
                          style: customButtonStyle,
                          child: Icon(Icons.color_lens),
                        ),
                        SizedBox(width: 40,),
                        ElevatedButton(
                          onPressed: _toggleBold,
                          style: customButtonStyle,
                          child: Text('Bold',style: TextStyle(fontSize: 20),),
                        ),
                        SizedBox(width: 40,),
                        ElevatedButton(
                          onPressed: _showFontPicker,
                          style: customButtonStyle,
                          child: Text('Choose Font', style: TextStyle(fontSize: 20),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Font Size', style: TextStyle(fontSize: 20, color: Colors.white),),
                        Container(
                          width: 250,
                          height: 40,
                          child: Slider(
                            value: _textSize,
                            onChanged: (value) {
                              setState(() {
                                _textSize = value;
                              });
                            },
                            min: 12.0,
                            max: 40.0,
                            divisions: 6,
                            label: _textSize.toStringAsFixed(1),
                            activeColor: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: _savePoemAndImage,
                    style: customButtonStyle,
                    child: Row(
                      children: [
                        Icon(Icons.save_alt),
                        SizedBox(width: 20,),
                        Text('Save', style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 140,
                  ),
                  ElevatedButton(
                    onPressed: _sharePoemAndImage,
                    style: customButtonStyle,
                    child: Row(
                      children: [
                        Icon(Icons.share),
                        SizedBox(width: 20,),
                        Text('Share', style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
