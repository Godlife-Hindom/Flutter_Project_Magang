import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key, required String title}) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtControllerBody = TextEditingController();
  bool _loading = false;
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _createPost() async {
    try {
      setState(() {
        _loading = true;
      });

      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'body': _txtControllerBody.text,
        'image': await MultipartFile.fromFile(_imageFile!.path),
      });

      final response = await dio.post(
        'http://127.0.0.1:8000/api/image',
        data: formData,
      );

      if (response.statusCode == 200) {
        // Posting berhasil, kirim path gambar ke halaman sebelumnya
        Navigator.of(context).pop(_imageFile?.path);
      } else {
        // Terjadi kesalahan dalam posting, tambahkan penanganan sesuai kebutuhan
        print('Gagal melakukan post: ${response.data}');
      }
    } catch (e) {
      // Tangani kesalahan
      print('Error: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    image: _imageFile == null
                        ? null
                        : DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.image,
                          size: 50, color: Colors.black38),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _txtControllerBody,
                      keyboardType: TextInputType.multiline,
                      maxLines: 9,
                      validator: (val) =>
                          val!.isEmpty ? 'Post body is required' : null,
                      decoration: const InputDecoration(
                        hintText: "Post body...",
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black38),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _createPost();
                      }
                    },
                    child: const Text('Post'),
                  ),
                )
              ],
            ),
    );
  }
}
