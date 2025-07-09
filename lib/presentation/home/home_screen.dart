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

  void _editUser(UsersResponse user) {
    // Mostrar dialog o navegar a pantalla de edición
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Usuario'),
        content: Text('¿Deseas editar a ${user.description}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Aquí puedes navegar a una pantalla de edición
              // Navigator.push(context, MaterialPageRoute(builder: (context) => EditUserScreen(user: user)));
            },
            child: Text('Editar'),
          ),
        ],
      ),
    );
  }

  void _deleteUser(UsersResponse user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Usuario'),
        content: Text(
          '¿Estás seguro de que deseas eliminar a ${user.description}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Aquí implementas la lógica de eliminación
              // context.read<HomeViewModel>().deleteUser(user);
            },
            child: Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
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
                    child: Text("Reintentar"),
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

  Dismissible itemList(UsersResponse user) => Dismissible(
    key: Key(user.id.toString()),
    direction: DismissDirection.horizontal,
    confirmDismiss: (direction) async {
      return false;
    },
    background: Container(
      color: Colors.green,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20),
      child: Icon(Icons.edit, color: Colors.white, size: 30),
    ),
    secondaryBackground: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      child: Icon(Icons.delete, color: Colors.white, size: 30),
    ),
    onDismissed: (direction) {
      if (direction == DismissDirection.startToEnd) {
        _editUser(user);
      } else if (direction == DismissDirection.endToStart) {
        _deleteUser(user);
      }
    },
    child: GestureDetector(
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
    ),
  );
}
