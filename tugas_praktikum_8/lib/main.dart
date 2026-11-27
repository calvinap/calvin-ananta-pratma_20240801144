import 'package:flutter/material.dart';
import 'models/user.dart';
import 'models/admin.dart';
import 'services/user_service.dart';
import '/services/admin_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum API Calvin',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final UserService userService = UserService();
  final AdminService adminService = AdminService();

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calvin Ananta - 20240801144'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'User (CRUD)'),
              Tab(text: 'Admin'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // TAB USER
            Column(
              children: [
                Wrap(
                  spacing: 8.0,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await userService.createUser('Calvin', 'calvin@email.com', 'Jakarta');
                          showMsg('POST User (ID 1643) Berhasil');
                        } catch (e) { showMsg('Error POST User'); }
                      },
                      child: const Text('POST User'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await userService.updateUser(1, 'Calvin Update', 'update@email.com');
                          showMsg('PUT User Berhasil');
                        } catch (e) { showMsg('Error PUT User'); }
                      },
                      child: const Text('PUT User'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await userService.patchUser(1, 'Calvin');
                          showMsg('PATCH: Calvin - Flutter Developer');
                        } catch (e) { showMsg('Error PATCH User'); }
                      },
                      child: const Text('PATCH User'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await userService.deleteUser(1);
                          showMsg('DELETE User Berhasil');
                        } catch (e) { showMsg('Error DELETE User'); }
                      },
                      child: const Text('DELETE User'),
                    ),
                  ],
                ),
                Expanded(
                  child: FutureBuilder<List<User>>(
                    future: userService.getUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                      if (snapshot.hasError) return const Center(child: Text('Error loading users'));
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final user = snapshot.data![index];
                          return ListTile(
                            title: Text(user.name),
                            subtitle: Text('${user.email} | ${user.city}'),
                            onTap: () => showMsg('Detail User: ${user.name} (ID: ${user.id})'),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            
            // TAB ADMIN
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                    onPressed: () async {
                      try {
                        // Menggunakan ID Admin sesuai NIM (936)
                        await adminService.deleteAdmin(936);
                        showMsg('DELETE Admin (ID 936) Berhasil');
                      } catch (e) { showMsg('Error DELETE Admin'); }
                    },
                    child: const Text('DELETE Admin (ID 936)'),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Admin>>(
                    future: adminService.getAdmins(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                      if (snapshot.hasError) return const Center(child: Text('Error loading admins'));
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final admin = snapshot.data![index];
                          return ListTile(
                            title: Text(admin.name),
                            subtitle: Text('${admin.email} | Dept: ${admin.department}'),
                            onTap: () => showMsg('Detail Admin: ${admin.name} (ID: ${admin.id})'),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}