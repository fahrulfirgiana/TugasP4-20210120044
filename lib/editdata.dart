import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final List list;
  final int index;

  const Edit({Key? key, required this.list, required this.index})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  late TextEditingController title;
  late TextEditingController content;

  void editData() async {
    var url = Uri.parse(
        'http://10.20.31.15/tugasp4/restapi/update.php'); //update api calling
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
      'title': title.text,
      'content': content.text,
    });
  }

  @override
  void initState() {
    title = TextEditingController(text: widget.list[widget.index]['title']);
    content = TextEditingController(text: widget.list[widget.index]['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Data"), // Mengganti judul AppBar
        shape: const BeveledRectangleBorder(),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
            child: TextFormField(
              controller: title,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Title',
                prefixIcon: Icon(Icons.title),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: TextFormField(
              controller: content,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Content',
                prefixIcon: Icon(Icons.text_snippet_outlined),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: MaterialButton(
              padding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 20), // Mengubah ukuran tombol
              color: Colors.indigo, // Mengubah warna tombol menjadi hijau
              onPressed: () {
                if (title.text.isNotEmpty && content.text.isNotEmpty) {
                  editData();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Home(),
                    ),
                  );
                } else {
                  // Handle empty input case, e.g., show a message to the user.
                }
              },
              child: const Text(
                "Edit Data",
                style: TextStyle(
                  color: Colors.white, // Mengubah warna teks menjadi putih
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
