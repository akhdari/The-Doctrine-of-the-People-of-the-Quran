import 'dart:developer' as log;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'dart:io';
import 'dart:typed_data';

// TODO permisson handelling
//https://pub.dev/packages/permission_handler

class Picker extends StatefulWidget {
  const Picker({super.key});

  @override
  State<Picker> createState() => _PickerState();
}

/*
Yes — a variable declared inside a try block is scoped to that block, meaning you can't access it outside unless you declare it before the try.
*/
//_image local variables should not be private
//Private (_) in Dart is library-scoped, not class-scoped or function-scoped.
//local var do not need extra encapsulation
/*
      When Should You Use _ (Private)?
      Only for class fields or top-level variables
      what is top level var?
      a top-level variable is a variable declared outside of any class, function, or method—
      */
class _PickerState extends State<Picker> {
  XFile? imageFile;

  Future<void> imagePicker() async {
    try {
      imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    } catch (e) {
      log.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: const Text('Pick Image'),
          onPressed: () async {
            await imagePicker();
            setState(() {}); // Rebuild the widget to show the image
          },
        ),
        const SizedBox(height: 16),
        if (imageFile != null)
          buildImage(imageFile)
        else
          const Text('No image selected.'),
      ],
    );
  }
}

/*
    Image.file(
      File(image.path),
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );

}*/
Widget buildImage(XFile? imageFile) {
  if (imageFile != null) {
    return FutureBuilder(
      future: imageFile.readAsBytes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Image.memory(
            snapshot.data as Uint8List,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          );
        } else if (snapshot.hasError) {
          return const Text('Error loading image');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  } else {
    return const Text('No image selected.');
  }
}
