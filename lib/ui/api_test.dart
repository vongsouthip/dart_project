import 'package:api_5/model/users_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiTest extends StatefulWidget {
  const ApiTest({super.key});

  @override
  State<ApiTest> createState() => _ApiTestState();
}

class _ApiTestState extends State<ApiTest> {
  // late Future<List<User>> users;
  List getUsersAPI = [];

  @override
  void initState() {
    super.initState();
    // users = loadUsersFromAssets();
  }

  // Future<List<User>> loadUsersFromAssets() async {
  //   String jsonString = await rootBundle.loadString('assets/data/users.json');
  //   List<dynamic> jsonData = jsonDecode(jsonString);
  //   return jsonData.map((user) => User.fromJson(user)).toList();
  // }

  Future<List<User>> getUsers() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/users',
      );
      getUsersAPI = response.data;
      return getUsersAPI.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('data')),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<User>>(
                future: getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No users found"));
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 5));
                        setState(() {});
                      },
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final user = snapshot.data![index];
                          return ListTile(
                            title: Text(user.name),
                            subtitle: Text(user.email),
                            leading: CircleAvatar(
                              child: Text(user.id.toString()),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await getUsers();
          },
          child: Icon(Icons.abc_outlined),
        ),
      ),
    );
  }
}
