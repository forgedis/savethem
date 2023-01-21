import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../model/spending.dart';
import 'home_page.dart';
import '../service/api_service.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../model/category.dart';

List<String> categoryNames = [''];

class AddPage extends ConsumerStatefulWidget {
  const AddPage({Key? key}) : super(key: key);
  static const String routeName = '/signup';

  @override
  ConsumerState<AddPage> createState() => _AddState();
}

class _AddState extends ConsumerState<AddPage> {
  final _nameTEC = TextEditingController();
  final _dateTEC = TextEditingController();
  final _priceTEC = TextEditingController();
  final _noteTEC = TextEditingController();
  List<Category> _categoryList = [];
  String _dropdownValue = categoryNames.first;
  DateTime _date = DateTime.now();
  late final String _formattedDate = DateFormat('dd.MM.yyyy').format(_date);
  String? _imageId;
  bool _imageAdded = false;
  InputFile _file = InputFile(path: '');

  /*
  This method gets data from the database and also sets data for categoryNames
   */
  void fetchData() async {
    final user = await ref.read(appwriteAccountProvider).get();
    _categoryList = await ApiService.instance.getCategory(userId: user.$id);

    setState(() {
      for (var element in _categoryList) {
        categoryNames.add(element.name);
      }
    });
  }

  Future pickImage(ImageSource source) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      _file = InputFile(path: image!.path);
      setState(() {
        _imageAdded = true;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    categoryNames.clear();
    categoryNames.add('');
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF261c51),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Name',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _nameTEC,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Date',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                readOnly: true,
                controller: _dateTEC,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: _date,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              builder: (context, child) => Theme(
                                    data: ThemeData().copyWith(
                                      colorScheme: const ColorScheme.dark(
                                        primary: Color(0xFFae91f9),
                                        onPrimary: Color(0xFFf1cb46),
                                        surface: Color(0xFFae91f9),
                                        onSurface: Color(0xFFf1cb46),
                                      ),
                                      dialogBackgroundColor:
                                          const Color(0xFF261c51),
                                    ),
                                    child: child!,
                                  ));

                          if (newDate == null) return;

                          setState(() => _date = newDate);

                          _dateTEC.text = _formattedDate;
                        },
                        icon: const Icon(Icons.calendar_month,
                            color: Colors.white))),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Price',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _priceTEC,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Category',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Container(
                  decoration: const ShapeDecoration(
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
                        value: _dropdownValue,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                        dropdownColor: const Color(0xFF8a5bf5),
                        elevation: 16,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        underline: Container(
                            height: 2, color: const Color(0xFFf1cb46)),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            _dropdownValue = value!;
                          });
                        },
                        items: categoryNames
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
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Note',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                color: const Color(0xFF261c51),
                elevation: 0,
                child: TextField(
                  controller: _noteTEC,
                  maxLines: 3, //or null
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                        showImageSource(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF8a5bf5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Add photo of receipt",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.camera_alt)
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFFf1cb46),
                    child: IconButton(
                      onPressed: () async {
                        // Getting imageId
                        if (_file.path != '') {
                          _imageId =
                              await ApiService.instance.uploadImage(_file);
                        }

                        // Getting categoryId
                        final categoryId = await ApiService.instance
                            .getCategoryId(categoryName: _dropdownValue);

                        // Getting user
                        final user =
                            await ref.read(appwriteAccountProvider).get();

                        // Creating spending object
                        final data = Spending(
                          name: _nameTEC.text,
                          date: _date,
                          price: double.parse(_priceTEC.text),
                          note: _noteTEC.text,
                          categoryId: categoryId,
                          userId: user.$id,
                          imageId: _imageId,
                        );

                        // Adding spending to database
                        try {
                          final spending = await ApiService.instance
                              .addSpending(spending: data);
                        } on AppwriteException catch (e) {
                          print(e.message);
                        }
                        Navigator.of(context)
                            .pushReplacementNamed(HomePage.routeName);
                      },
                      icon:
                          const Icon(Icons.save, color: Colors.black, size: 30),
                      color: const Color(0xFFf1cb46),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              if (_imageAdded) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.green),
                      Text(' Image added',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ],
                  ),
                )
              ]
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
                      child: const Text('Gallery'),
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                        print('was clicked');
                      }),
                  CupertinoActionSheetAction(
                      child: const Text('Camera'),
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
          shape: const RoundedRectangleBorder(
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
                    leading: const Icon(
                      Icons.photo_outlined,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Upload from gallery',
                    ),
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.of(this.context).pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Take picture',
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
