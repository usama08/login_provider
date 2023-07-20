import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../controller/provider_controller.dart';

class AddCase extends StatefulWidget {
  const AddCase({Key? key}) : super(key: key);

  @override
  State<AddCase> createState() => _AddCaseState();
}

class _AddCaseState extends State<AddCase> {
  late File? image;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controllerProvidertext =
        Provider.of<MainScreenController>(context, listen: true);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            textfield(
              context,
              controllerProvidertext.lawyername,
              "Lawyer Name",
              "Lawyer Name",
            ),
            SizedBox(height: 10),
            textfield(
              context,
              controllerProvidertext.lawyernumber,
              "Lawyer Number",
              "Lawyer Number",
            ),
            SizedBox(height: 10),
            textfield(
              context,
              controllerProvidertext.clintname,
              "Client Name",
              "Client Name",
            ),
            SizedBox(height: 10),
            textfield(
              context,
              controllerProvidertext.clintnumber,
              "Client Number",
              "Client Number",
            ),
            SizedBox(height: 10),
            textfield(
              context,
              controllerProvidertext.datainfo,
              "Additional Information",
              "Additional Information",
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  controllerProvidertext.selectDate(context);
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controllerProvidertext.formattedDate,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Add Image'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            GestureDetector(
                              child: const Text('Gallery'),
                              onTap: () {
                                _getImage(ImageSource.gallery);
                                Navigator.of(context).pop();
                              },
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              child: const Text('Camera'),
                              onTap: () {
                                _getImage(ImageSource.camera);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Image'),
            ),
            ElevatedButton(
              onPressed: () {
                controllerProvidertext.insertData();
              },
              child: const Text('Insert Data'),
            ),
          ],
        ),
      ),
    );
  }
}
