import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test/data/datasource/user_datasource.dart';
import 'package:technical_test/domain/repositories/user_repository.dart';
import 'package:technical_test/domain/useCase/user_use_case.dart';
import 'package:technical_test/presentation/home/home_view_model.dart';
import 'package:technical_test/presentation/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            final remoteDataSource = UserDataSource();
            final repository = UserRepository(remoteDataSource);
            final useCase = GetUsersUseCase(repository);
            return HomeViewModel(useCase);
          },
        ),
      ],
      child: const MaterialApp(home: LoginScreen()),
    );
  }
}
