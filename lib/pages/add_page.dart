import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:savethem/model/spending.dart';
import 'package:savethem/service/api_service.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'expenses_page.dart';

const List<String> categoryList = <String>[
  'Groceries',
  'Housing',
  'Fun',
  'Restaurant',
  'Car',
  'Custom'
];

class AddPage extends ConsumerStatefulWidget {
  const AddPage({Key? key}) : super(key: key);
  static const String routeName = '/signup';

  @override
  ConsumerState<AddPage> createState() => _AddState();
}

class _AddState extends ConsumerState<AddPage> {
  final nameTEC = TextEditingController();
  final dateTEC = TextEditingController();
  final priceTEC = TextEditingController();

  String dropdownValue = categoryList.first;

  DateTime date = DateTime.now();
  late String formattedDate = DateFormat('dd.MM.yyyy').format(date);
  String? imageID;

  InputFile file = InputFile(path: '');

  Future pickImage(ImageSource source) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      file = InputFile(path: image!.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF261c51),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(ExpensesPage.routeName);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'SaveThem',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Name',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: nameTEC,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Date',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: dateTEC,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF8a5bf5), width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              builder: (context, child) => Theme(
                                    data: ThemeData().copyWith(
                                      colorScheme: ColorScheme.dark(
                                        primary: Color(0xFFae91f9),
                                        onPrimary: Color(0xFFf1cb46),
                                        surface: Color(0xFFae91f9),
                                        onSurface: Color(0xFFf1cb46),
                                      ),
                                      dialogBackgroundColor: Color(0xFF261c51),
                                    ),
                                    child: child!,
                                  ));

                          if (newDate == null) return;

                          setState(() => date = newDate);

                          dateTEC.text = formattedDate;
                        },
                        icon: Icon(Icons.calendar_month, color: Colors.white))),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Price',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: priceTEC,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Category',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 2.0,
                          style: BorderStyle.solid,
                          color: Color(0xFF8a5bf5)),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  ),
                  width: 350,
                  height: 60,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                        dropdownColor: Color(0xFF8a5bf5),
                        elevation: 16,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                        underline:
                            Container(height: 2, color: Color(0xFFf1cb46)),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: categoryList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 220,
                    child: ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Add photo of receipt",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.camera_alt)
                        ],
                      ),
                      onPressed: () {
                        showImageSource(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF8a5bf5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFFf1cb46),
                    child: IconButton(
                      onPressed: () async {
                        if (file.path != '') {
                          imageID = await ApiService.instance.uploadImage(file);
                        }

                        final user =
                            await ref.read(appwriteAccountProvider).get();
                        final data = Spending(
                          name: nameTEC.text,
                          date: date,
                          price: double.parse(priceTEC.text),
                          category: dropdownValue,
                          userID: user.$id,
                          imageID: imageID,
                        );
                        try {
                          final spending = await ApiService.instance
                              .addSpending(spending: data);
                        } on AppwriteException catch (e) {
                          print(e.message);
                        }

                        Navigator.of(context)
                            .pushReplacementNamed(ExpensesPage.routeName);
                      },
                      icon:
                          const Icon(Icons.save, color: Colors.black, size: 30),
                      color: Color(0xFFf1cb46),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      child: Text('Gallery'),
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                        print('was clicked');
                      }),
                  CupertinoActionSheetAction(
                      child: Text('Camera'),
                      onPressed: () {
                        pickImage(ImageSource.camera);
                        Navigator.of(context).pop();
                        print('was clicked');
                      })
                ],
              ));
    } else {
      showModalBottomSheet(
          enableDrag: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          context: this.context,
          builder: (builder) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.photo_outlined,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Upload from gallery',
                      style: TextStyle(fontFamily: 'Lato'),
                    ),
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.of(this.context).pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Take picture',
                      style: TextStyle(fontFamily: 'Lato'),
                    ),
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.of(this.context).pop(context);
                    },
                  ),
                ],
              ));
    }
  }
}
