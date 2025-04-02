import 'dart:developer' as log;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// TODO permisson handelling

class Picker extends StatefulWidget {
  const Picker({super.key});

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  //XFILE is a an image picker class that represent a file with cross platform compatibility
  XFile? imageFile;
  void imagePicker() async {
    //image source: camera or gallery
    try {
      //_image local variables should not be private
      //Private (_) in Dart is library-scoped, not class-scoped or function-scoped.
      //local var do not need extra encapsulation
      /*
      When Should You Use _ (Private)?
      Only for class fields or top-level variables
      what is top level var?
      a top-level variable is a variable declared outside of any class, function, or method—
      */
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        //resize image if the width and the height of the image is greater then max width and height
      );
      if (image != null) {
        setState(() {
          imageFile = image;
        });
      } else {
        String msg = 'No image selected.';
        //possible naming conflicts
        log.log(msg);
      }
    } catch (e) {
      log.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Pick Image'),
      onPressed: () {
        imagePicker();
      },
    );
  }
}
