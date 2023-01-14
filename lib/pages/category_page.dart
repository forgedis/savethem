import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:savethem/model/category.dart';
import 'package:savethem/service/api_service.dart';

import '../main.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  late final user;
  String editCategoryID = '';
  String deleteCategoryID = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser();
    addCategoryTEC.clear();
  }

  void getUser() async {
    setState(() => isLoading = true);
    final retrievedUser = await ref.read(appwriteAccountProvider).get();

    setState(() {
      user = retrievedUser;
    });

    setState(() => isLoading = false);
  }

  final addCategoryTEC = TextEditingController();
  final editCategoryTEC = TextEditingController();

  _displayAddCategoryDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFF261c51),
            title: Text(
              'Add new category',
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: addCategoryTEC,
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
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              ElevatedButton(
                child: new Text('Add'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF8a5bf5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () async {
                  final user = await ref.read(appwriteAccountProvider).get();

                  final data =
                      Category(name: addCategoryTEC.text, userID: user.$id);
                  final category =
                      await ApiService.instance.addCategory(category: data);
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: new Text('Cancel'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF8a5bf5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _displayEditCategoryDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFF261c51),
            title: Text(
              'Edit category',
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: editCategoryTEC,
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
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              ElevatedButton(
                child: new Text('Save'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF8a5bf5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () async {
                  Category updatedCategory =
                      Category(name: editCategoryTEC.text, userID: user.$id);

                  await ApiService.instance.updateCategory(
                      categoryID: editCategoryID,
                      categoryToUpdate: updatedCategory);

                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: new Text('Cancel'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF8a5bf5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => _displayAddCategoryDialog(context),
                icon: Icon(
                  Icons.add_circle_outlined,
                  size: 30,
                ))
          ],
        ),
        backgroundColor: Color(0xFF261c51),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (isLoading) ...[
                  SpinKitThreeBounce(
                    color: Colors.white,
                    size: 50.0,
                  )
                ],
                if (!isLoading) ...[
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: FutureBuilder<List<Category>>(
                      future: ApiService.instance.getCategory(userID: user.$id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  color: Color(0xFF8a5bf5),
                                  elevation: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data![index].name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              final categoryid =
                                                  await ApiService.instance
                                                      .getCategoryID(
                                                          categoryName: snapshot
                                                              .data![index]
                                                              .name);

                                              setState(() {
                                                editCategoryID = categoryid;
                                                editCategoryTEC.text =
                                                    snapshot.data![index].name;
                                              });
                                              _displayEditCategoryDialog(
                                                  context);
                                            },
                                            icon: Icon(Icons.edit,
                                                color: Color(0xFFf1cb46)),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              final categoryid =
                                                  await ApiService.instance
                                                      .getCategoryID(
                                                          categoryName: snapshot
                                                              .data![index]
                                                              .name);

                                              setState(() {
                                                deleteCategoryID = categoryid;
                                              });

                                              ApiService.instance
                                                  .deleteCategory(
                                                      categoryID:
                                                          deleteCategoryID);
                                            },
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        // By default show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
