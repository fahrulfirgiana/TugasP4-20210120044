import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details.dart';
import 'newdata.dart';

void main() => runApp(MaterialApp(
      title: "API Test",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    var url =
        Uri.parse('http://10.20.31.15/tugasp4/restapi/list.php'); // URL API
    final response =
        await http.get(url); // Menggunakan GET untuk mengambil data
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PHP MySQL CRUD"),

        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const NewData(),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.indigo, // Warna latar belakang AppBar
        elevation: 2, // Efek bayangan di bawah AppBar
      ),
      extendBody: true,
      body: FutureBuilder<List>(
        future: getData(),
        builder: (ctx, ss) {
          if (ss.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (ss.hasError) {
            return Center(
              child: Text('Error fetching data: ${ss.error}'),
            );
          } else if (ss.hasData) {
            return Items(list: ss.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  final List list;
  const Items({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (ctx, i) {
        return ListTile(
          leading: const Icon(Icons.text_snippet_outlined),
          title: Text(list[i]['title']),
          subtitle: Text(list[i]['content']),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    Details(list: list, index: i),
              ),
            );
          },
        );
      },
    );
  }
}
