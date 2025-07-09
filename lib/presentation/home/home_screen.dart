import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test/data/models/users_response.dart';
import 'package:technical_test/presentation/home/home_view_model.dart';
import 'package:technical_test/presentation/search_user_map/search_user_map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Llamar a fetchUsers cuando se inicializa la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Consumer<HomeViewModel>(
        builder: (context, vm, child) {
          if (vm.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (vm.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${vm.error}'),
                  ElevatedButton(
                    onPressed: () => vm.fetchUsers(),
                    child: Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: vm.users.length,
            itemBuilder: (context, index) {
              final user = vm.users[index];
              return itemList(user);
            },
          );
        },
      ),
    );
  }

  GestureDetector itemList(UsersResponse user) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchUserMap(model: user)),
      );
    },
    child: Card(
      child: ListTile(
        leading: Image.network(
          user.photoUrl,
          width: 60,
          height: 60,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 60,
              color: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            );
          },
        ),
        title: Text(user.description),
        subtitle: Text(user.locationDescription),
      ),
    ),
  );
}
