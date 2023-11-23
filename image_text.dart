import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Image_to_text extends StatefulWidget {
  const Image_to_text({Key? key}) : super(key: key);

  @override
  State<Image_to_text> createState() => _Image_to_textState();
}

class _Image_to_textState extends State<Image_to_text> {
  String result = "";
  File? image;
  late Future<File> imageFile;
  ImagePicker? imagePicker;

  performImageLabelling()async
  {
    final FirebaseVisionImage firebaseVisionImage =FirebaseVisionImage.fromFile(image);
    final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await recognizer.processImage(firebaseVisionImage);
    result="";
    setState(() {
      for(TextBlock block in visionText.blocks)
      {
        // final String txt = block.text;
        for(TextLine line in block.lines)
        {
          result +="${line.text}\n";
          // for(TextElement element in line.elements)
          // {
          //   result +="${element.text} ";
          // }
        }
        // result += "\n\n";
      }
    });
  }
  pickImageFromGallary() async {
    XFile? pickedFile =await imagePicker?.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {
      image;
      performImageLabelling();
    });
  }

  captureImageWithCamera() async {
    XFile? pickedFile =await imagePicker?.pickImage(source: ImageSource.camera);
    image = File(pickedFile!.path);
    setState(() {
      image;
      performImageLabelling();
    });
  }

  // CropImage() {
  //   GlobalKey<CropState> cropKey = GlobalKey<CropState>();
  //   return Crop(
  //     key: cropKey,
  //     image: Image.file(_imageFile),
  //   );
  // }

  @override
  void initState()
  {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text('Image To Text Converter',
            style: TextStyle(fontSize: 25),),
        leading: const Icon(
          Icons.home,
          color: Colors.white,
          size: 45,
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 750,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 30),
                        width: 250,
                        height: 250,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/icon.png'))),
                        child: image != null
                            ? Image.file(
                          image!,
                          fit: BoxFit.cover,
                        )
                            : const SizedBox(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 135,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'Converted',arguments: result);
                          },
                          child: const Text(
                            "Convert",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 55,
                  color: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            pickImageFromGallary();
                          },
                          icon: const Icon(
                            Icons.image,
                            size: 45,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            captureImageWithCamera();
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 45,
                            color: Colors.white,
                          ))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
