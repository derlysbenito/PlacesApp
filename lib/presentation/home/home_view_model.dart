import 'package:flutter/material.dart';
import 'package:technical_test/domain/useCase/user_use_case.dart';
import '../../../data/models/users_response.dart';

class HomeViewModel extends ChangeNotifier {
  final GetUsersUseCase getUsersUseCase;

  HomeViewModel(this.getUsersUseCase);

  List<UsersResponse> _users = [];
  List<UsersResponse> get users => _users;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> fetchUsers() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await getUsersUseCase.execute();
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }
}
