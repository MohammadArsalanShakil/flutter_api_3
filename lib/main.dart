import 'package:flutter/material.dart';
import '/models/blogpost.dart';

import 'controllers/apifunctions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("API"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: BlogPostWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class BlogPostWidget extends StatefulWidget {
  const BlogPostWidget({
    Key? key,
  }) : super(key: key);

  @override
  _BlogPostWidgetState createState() => _BlogPostWidgetState();
}

class _BlogPostWidgetState extends State<BlogPostWidget> {
  APIFunctions _apiFunctions = APIFunctions();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlogPost>?>(
      future: _apiFunctions.fetchAllBlogPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    tileColor: Colors.blue.shade100,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.25,
                        color: Colors.blueGrey,
                      ),
                    ),
                    title: Text(
                      snapshot.data![index].title!,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return const Text("Data is Null");
        } else
          return const CircularProgressIndicator();
      },
    );
  }
}
