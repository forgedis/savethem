import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/category.dart';
import '../service/api_service.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late final _user;
  String _editCategoryId = '';
  String _deleteCategoryId = '';
  bool _isLoading = false;
  final _addCategoryTEC = TextEditingController();
  final _editCategoryTEC = TextEditingController();

  void getUser() async {
    setState(() => _isLoading = true);
    final retrievedUser = await ApiService.instance.getUser();

    setState(() {
      _user = retrievedUser;
    });

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getUser();
    _addCategoryTEC.clear();
  }

  _displayAddCategoryDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF261c51),
            title: const Text(
              'Add new category',
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: _addCategoryTEC,
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
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF8a5bf5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () async {
                  final data =
                      Category(name: _addCategoryTEC.text, userId: _user.id);
                  final category =
                      await ApiService.instance.addCategory(category: data);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF8a5bf5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
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
            backgroundColor: const Color(0xFF261c51),
            title: const Text(
              'Edit category',
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: _editCategoryTEC,
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
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF8a5bf5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () async {
                  Category updatedCategory =
                      Category(name: _editCategoryTEC.text, userId: _user.$id);

                  await ApiService.instance.updateCategory(
                      categoryId: _editCategoryId,
                      categoryToUpdate: updatedCategory);

                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF8a5bf5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
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
                icon: const Icon(
                  Icons.add_circle_outlined,
                  size: 30,
                ))
          ],
        ),
        backgroundColor: const Color(0xFF261c51),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_isLoading) ...[
                  const SpinKitThreeBounce(
                    color: Colors.white,
                    size: 50.0,
                  )
                ],
                if (!_isLoading) ...[
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: FutureBuilder<List<Category>>(
                      future: ApiService.instance.getCategory(userId: _user.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  color: const Color(0xFF8a5bf5),
                                  elevation: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data![index].name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              final categoryId =
                                                  await ApiService.instance
                                                      .getCategoryId(
                                                          categoryName: snapshot
                                                              .data![index]
                                                              .name);

                                              setState(() {
                                                _editCategoryId = categoryId;
                                                _editCategoryTEC.text =
                                                    snapshot.data![index].name;
                                              });
                                              _displayEditCategoryDialog(
                                                  context);
                                            },
                                            icon: const Icon(Icons.edit,
                                                color: Color(0xFFf1cb46)),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              final categoryId =
                                                  await ApiService.instance
                                                      .getCategoryId(
                                                          categoryName: snapshot
                                                              .data![index]
                                                              .name);

                                              setState(() {
                                                _deleteCategoryId = categoryId;
                                              });

                                              ApiService.instance
                                                  .deleteCategory(
                                                      categoryId:
                                                          _deleteCategoryId);
                                            },
                                            icon: const Icon(Icons.delete,
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
