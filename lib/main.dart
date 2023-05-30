import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}
//

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ImageScreen(),
    );
  }
}

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  XFile? imageFile;
  _openGallery(BuildContext context, ImageSource imageSource) async {
    XFile? picture = await ImagePicker().pickImage(source: imageSource);
    Navigator.of(context).pop();
    setState(() {
      imageFile = picture;
    });
  }

  Future<void> _choiceDilouge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choice anyone"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context, ImageSource.gallery);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openGallery(context, ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _deviceselectimage(XFile? imageFile) {
    if (imageFile == null) {
      return const Text("No Image Selected!");
    } else {
      //return Text(imageFile.name);
      return InteractiveViewer(
        child: Image.file(
          File(imageFile.path),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Image Pick",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _deviceselectimage(imageFile),
              ElevatedButton(
                  onPressed: () {
                    _choiceDilouge(context);
                  },
                  child: Text("Select Image"))
            ],
          ),
        ),
      ),
    );
  }
}
