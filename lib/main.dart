import 'package:flutter/material.dart';
import 'package:silveroakworkshop/models/user.dart';
import 'package:silveroakworkshop/screens/addUser.dart';
import 'package:silveroakworkshop/screens/editUser.dart';
import 'package:silveroakworkshop/screens/viewUser.dart';
import 'package:silveroakworkshop/services/userService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _userList = <User>[];
  final _userService = UserService();

  getAllUserDetails() async {
    var allusers = await _userService.readAllUser();
    _userList = <User>[];
    allusers.forEach((u) {
      setState(() {
        var userModel = User();
        userModel.id = u['id'];
        userModel.name = u['name'];
        userModel.contact = u['contact'];
        userModel.description = u['description'];
        _userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showNotification(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD Demo'),
      ),
      body: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewUser(user: _userList[index]),
                    ),
                  );
                },
                leading: Icon(Icons.person),
                title: Text(_userList[index].name ?? ''),
                subtitle: Text(_userList[index].contact ?? ''),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditUser(user: _userList[index]),
                        ),
                      ).then((value) {
                        if (value != null) {
                          getAllUserDetails();
                          _showNotification("User Updated Sucessfully");
                        }
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var result =
                          await _userService.deleteUser(_userList[index].id);
                      print(result);
                      if (result != null) {
                        setState(() {});
                        getAllUserDetails();
                        _showNotification("User Deleted");
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ]),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddUser()))
              .then((value) {
            if (value != null) {
              getAllUserDetails();
              _showNotification("User Added Sucessfully");
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
