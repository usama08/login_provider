import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/lawyer_model.dart';

class MainScreenController with ChangeNotifier {
  String _text = '';
  late DateTime selectedDate;
  // ignore: prefer_typing_uninitialized_variables
  var formattedDate;
  late File? image;

  MainScreenController() {
    selectedDate = DateTime.now();
    formattedDate = DateFormat('d MMM, yyyy').format(selectedDate);
  }

  String get text => _text;
  TextEditingController lawyername = TextEditingController();
  TextEditingController lawyernumber = TextEditingController();
  TextEditingController clintname = TextEditingController();
  TextEditingController clintnumber = TextEditingController();
  TextEditingController selectdate = TextEditingController();
  TextEditingController datainfo = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      formattedDate = DateFormat('d MMM, yyyy').format(selectedDate);
      notifyListeners();
    }
  }

  Future<void> getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      notifyListeners();
    }
  }

  Future<void> insertData() async {
    try {
      // Create a document reference to the "myDb" collection
      final CollectionReference myDbCollection =
          FirebaseFirestore.instance.collection('myDb');

      // Insert the data into the collection
      await myDbCollection.add({
        'lawyerName': lawyername.text,
        'lawyernumber': lawyernumber.text,
        'clintname': clintname.text,
        'clintnumber': clintnumber.text,
        'startdate': formattedDate,
        'datainfo': datainfo.text,

        // Add other fields as needed
      });

      // Reset the text field
      lawyername.clear();
      lawyernumber.clear();
      clintname.clear();
      clintnumber.clear();
      datainfo.clear();

      // Display a success message or perform any other desired actions
      print('Data inserted successfully!');
    } catch (error) {
      // Handle any errors that occur during data insertion
      print('Error inserting data: $error');
    }
  }
  ////////// to view Data from db on screen ////////////

  List<Lawyer> _lawyers = [];

  List<Lawyer> get lawyers => _lawyers;

  Future<void> fetchLawyers() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('myDb').get();

      final lawyers = snapshot.docs.map((doc) {
        final data = doc.data();
        return Lawyer(
          lawyerName: data['lawyerName'],
          lawyernumber: data['lawyernumber'],
          clintname: data['clintname'],
          clintnumber: data['clintnumber'],
          datainfo: data['datainfo'],
          startdate: data['startdate'],
        );
      }).toList();

      _lawyers = lawyers;
      notifyListeners();
    } catch (error) {
      print('Error fetching lawyers: $error');
    }
  }

  void setText(String newText) {
    _text = newText;
    notifyListeners();
  }

  Future<void> updateLawyer(Lawyer updatedLawyer) async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection('myDb');
      final querySnapshot = await collectionRef
          .where('lawyerName', isEqualTo: updatedLawyer.lawyerName)
          .get();

      if (querySnapshot.size > 0) {
        final docId = querySnapshot.docs.first.id;

        await collectionRef.doc(docId).update({
          'lawyernumber': updatedLawyer.lawyernumber,
          'clintname': updatedLawyer.clintname,
          'clintnumber': updatedLawyer.clintnumber,
          'datainfo': updatedLawyer.datainfo,
          'startdate': updatedLawyer.startdate,
        });

        final updatedIndex = _lawyers.indexWhere(
            (lawyer) => lawyer.lawyerName == updatedLawyer.lawyerName);
        if (updatedIndex != -1) {
          _lawyers[updatedIndex] = updatedLawyer;
          notifyListeners();
        }
      }
    } catch (error) {
      print('Error updating lawyer: $error');
    }
  }
}
