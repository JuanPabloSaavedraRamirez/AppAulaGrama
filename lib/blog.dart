import 'package:app_aulagramma/menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Blog extends StatefulWidget {
  final String username;

  const Blog({super.key, required this.username});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  List<String> blogPosts = [];
  final TextEditingController _controller = TextEditingController();
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('IDUser');
    });
  }

  void _addPost() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        blogPosts.add(_controller.text);
        _controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog',
          style: TextStyle(
            color: Color(0xFF040F51),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      endDrawer: Menu(),
      body: Column(
        children: [
          if (userId == "2")
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Escribe una nueva entrada',
                      labelStyle: TextStyle(color: Color(0xFF040F51)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addPost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7C8CB2),
                      foregroundColor: Color(0xFF040C52),
                    ),
                    child: Text('Agregar entrada'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: blogPosts.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      blogPosts[index],
                      style: TextStyle(color: Color(0xFF040F51)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF040F51),
    );
  }
}
