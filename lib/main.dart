import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.white,
        primaryColor: Colors.white,
        brightness: Brightness.light,
      ),
      home: const CoreData(),
    ));

class CoreData extends StatefulWidget {
  const CoreData({Key? key}) : super(key: key);

  @override
  _CoreDataState createState() => _CoreDataState();
}
Future getCoreData() async {
  try {
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/users');
    print(response);
    return response;
  } catch (e) {
    print(e);
  }
}

class Core {
  String name;
  String userName;
  String email;

  Core(
    this.name,
    this.userName,
    this.email,
  );
  factory Core.fromJson(dynamic json) {
    return Core(
      json["name"] as String,
      json["userName"] as String,
      json["email"] as String,
    );
  }
}

class _CoreDataState extends State<CoreData> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Core Data API Testing'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getCoreData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: (snapshot.data as dynamic).length,
                itemBuilder: (context, index) {
                  Core users = (snapshot.data as dynamic)[index];
                  return  ListTile(
                    title: Text(users.name,),
                    subtitle: Text(users.email,),
                    leading: Text(users.userName,),
                    trailing: const Icon(
                      Icons.add,
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Container(
                child: const Center(
                  child: Text('Connection not Successful '),
                ),
              );
            } else {
              return Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCoreData();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
