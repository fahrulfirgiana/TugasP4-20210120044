import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class NewData extends StatefulWidget {
  const NewData({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void addData() async {
    var url = Uri.parse(
        'http://10.20.31.15/tugasp4/restapi/create.php'); // API Insert
    final response = await http.post(url, body: {
      "title": titleController.text,
      "content": contentController.text,
    });

    if (response.statusCode == 200) {
      // Jika berhasil menambahkan data, kembali ke halaman utama
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const Home(),
        ),
      );
    } else {
      // Jika gagal, tampilkan pesan kesalahan
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to add data.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Blog"),
        shape: const BeveledRectangleBorder(
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Enter Title',
                prefixIcon: Icon(Icons.title),
              ),
            ),
            TextFormField(
              controller: contentController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Enter Content',
                prefixIcon: Icon(Icons.text_snippet_outlined),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addData();
              },
              child: const Text("Add Data"),
            ),
          ],
        ),
      ),
    );
  }
}
