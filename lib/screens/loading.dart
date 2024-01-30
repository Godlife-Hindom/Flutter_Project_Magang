import 'package:flutter/material.dart';
import 'package:project_magang/screens/home.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    // Tambahkan logika atau penundaan jika diperlukan
    await Future.delayed(Duration(seconds: 2));

    // Pindah ke halaman Home tanpa melakukan pengecekan apapun
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator()
        ),
      ),
    );
  }
}
