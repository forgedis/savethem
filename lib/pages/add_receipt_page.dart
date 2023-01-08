import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savethem/model/receipt.dart';
import 'package:savethem/service/api_service.dart';
import '../main.dart';

class AddReceiptPage extends ConsumerStatefulWidget {
  const AddReceiptPage({Key? key}) : super(key: key);
  static const String routeName = '/signup';

  @override
  ConsumerState<AddReceiptPage> createState() => _SignupState();
}

class _SignupState extends ConsumerState<AddReceiptPage> {

  final nameTEC = TextEditingController();
  final dateTEC = TextEditingController();
  final priceTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF261c51),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton
          (onPressed: () {
          Navigator.pop(context);
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
                        prefixIcon: Icon(
                          Icons.space_bar,
                          color: Colors.transparent,
                        )),
                    style: TextStyle(color: Colors.white),
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
                        prefixIcon: Icon(
                          Icons.space_bar,
                          color: Colors.transparent,
                        )),
                    style: TextStyle(color: Colors.white),
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
                        prefixIcon: Icon(
                          Icons.space_bar,
                          color: Colors.transparent,
                        )),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Add photo",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.camera_alt)
                            ],
                          ),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Color(0xFF8a5bf5),
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
                            final user = await ref.read(appwriteAccountProvider).get();
                            final data = Receipt(userID: user.$id, receiptName: nameTEC.text, date: dateTEC.text, price: double.parse(priceTEC.text));
                            try {
                              final receipt = await ApiService.instance.addReceipt(receipt: data);
                            } on AppwriteException catch (e) {
                              print(e.message);
                            }
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.save,
                              color: Colors.black, size: 30),
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
}
