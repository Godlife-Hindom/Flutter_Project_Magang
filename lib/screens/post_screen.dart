
import 'package:project_magang/models/api_response.dart';
import 'package:project_magang/models/post.dart';
import 'package:project_magang/services/post_service.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<dynamic> _postList = [];
  bool _loading = true;

  // get all posts
  Future<void> retrievePosts() async {
    ApiResponse response = getPosts() as ApiResponse;

    if(response.error == null){
      setState(() {
        _postList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? const Center(child:CircularProgressIndicator()) :
    RefreshIndicator(
      onRefresh: () {
        return retrievePosts();
      },
      child: ListView.builder(
        itemCount: _postList.length,
        itemBuilder: (BuildContext context, int index){
          Post post = _postList[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),
                  ],
                ),
               SizedBox(
                height: 12,
                child: post.image != null && post.image!.isNotEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('${post.image}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
                const Row(
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  color: Colors.black26,
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}