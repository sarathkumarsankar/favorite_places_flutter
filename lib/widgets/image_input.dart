import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  final Function(File image)? onPickedImage;
  const ImageInput({
    super.key,
    this.onPickedImage,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        decoration: BoxDecoration(
            border: Border.all(
          width: 1,
          color: const Color.fromRGBO(134, 127, 127, 1),
        )),
        width: double.infinity,
        child: selectedImage == null
            ? SizedBox(
                height: 50,
                width: 100,
                child: TextButton.icon(
                    onPressed: () {
                      pickImage((image) {
                        setState(() {
                          selectedImage = image;
                          widget.onPickedImage!(image);
                        });
                      });
                    },
                    icon: const Icon(CupertinoIcons.camera),
                    label: const Text("Take picture")),
              )
            : GestureDetector(
                onTap: () => pickImage((image) => null),
                child: Image.file(
                  selectedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ));
  }

  void pickImage(Function(File image) onPickedImage) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    onPickedImage(File(pickedImage.path));
  }
}
