import 'package:silveroakworkshop/dbhelper/repository.dart';
import 'package:silveroakworkshop/models/user.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }

// Save User
  saveUser(User user) async {
    return await _repository.insertData('users', user.userMap());
  }

  // Read All user

  readAllUser() async {
    return await _repository.readData('users');
  }

// Edit and Update User
  updateUser(User user) async {
    return await _repository.updateData('users', user.userMap());
  }

  deleteUser(id) async {
    return await _repository.deleteDataById('users', id);
  }
}
