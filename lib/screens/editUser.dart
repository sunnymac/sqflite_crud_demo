import 'package:flutter/material.dart';
import 'package:silveroakworkshop/models/user.dart';
import 'package:silveroakworkshop/services/userService.dart';

class EditUser extends StatefulWidget {
  final User user;
  const EditUser({
    super.key,
    required this.user,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var _userNameController = TextEditingController();
  var _userContactController = TextEditingController();
  var _userDescriptionController = TextEditingController();
  bool _emptyName = false;
  bool _emptyContact = false;
  bool _emptyDescr = false;
  var _userService = UserService();

  @override
  void initState() {
    _userNameController.text = widget.user.name ?? '';
    _userContactController.text = widget.user.contact ?? '';
    _userDescriptionController.text = widget.user.description ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite CRUD Demo"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit User",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  label: Text("Name"),
                  border: OutlineInputBorder(),
                  hintText: "Enter Name",
                  errorText: _emptyName ? 'Name can not be empty' : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                controller: _userContactController,
                decoration: InputDecoration(
                  label: Text("Contact"),
                  border: OutlineInputBorder(),
                  hintText: "Enter Contact",
                  errorText: _emptyContact ? 'Contact can not be empty' : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _userDescriptionController,
                decoration: InputDecoration(
                  label: Text("Desciption"),
                  border: OutlineInputBorder(),
                  hintText: "Enter Description",
                  errorText:
                      _emptyDescr ? 'Description can not be empty' : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      textStyle: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () async {
                      setState(
                        () {
                          _userNameController.text.isEmpty
                              ? _emptyName = true
                              : _emptyName = false;
                          _userContactController.text.isEmpty
                              ? _emptyContact = true
                              : _emptyContact = false;
                          _userDescriptionController.text.isEmpty
                              ? _emptyDescr = true
                              : _emptyDescr = false;
                        },
                      );
                      if (_emptyName == false &&
                          _emptyContact == false &&
                          _emptyDescr == false) {
                        debugPrint("Ready to send data in DB");
                        var _user = User();
                        _user.id = widget.user.id;
                        _user.name = _userNameController.text;
                        _user.contact = _userContactController.text;
                        _user.description = _userDescriptionController.text;
                        var result = await _userService.updateUser(_user);
                        print(result);

                        Navigator.pop(context, result);

                        //print(result);
                      }
                    },
                    child: Text("Update Details"),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      _userNameController.text = "";
                      _userContactController.text = "";
                      _userDescriptionController.text = "";
                    },
                    child: Text("Clear Details"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
