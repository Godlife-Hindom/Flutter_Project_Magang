import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_magang/screens/post_form.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<String> _imageList = []; // Daftar path gambar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: _imageList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            child: Image.file(File(_imageList[index])),
          );
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PostForm(title: 'Post')),
            );

            if (result != null && result is String) {
              // Jika ada hasil (path gambar baru), tambahkan ke daftar gambar
              setState(() {
                _imageList.add(result);
              });
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Handle item tap
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
