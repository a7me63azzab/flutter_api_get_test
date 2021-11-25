import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_get_test/src/Pages/home_page/model.dart';
import 'package:flutter_api_get_test/src/Pages/home_page/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostApiServiec postApiServiec = PostApiServiec();

  @override
  void initState() {
    // postApiServiec.getAllPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Posts"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<AllPosts>>(
        future: postApiServiec.getAllPosts(),
        builder: (context, AsyncSnapshot<List<AllPosts>> snapshot) {
          return !snapshot.hasData
              ? const Center(
                  child: CupertinoActivityIndicator(
                    animating: true,
                    radius: 16,
                  ),
                )
              : ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    if (snapshot.hasData) {
                      return ListItem(
                        name: snapshot.data?[index].title,
                        body: snapshot.data?[index].body?.substring(1, 50),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Server Error !"));
                    } else {
                      return Container();
                    }
                  },
                );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String? name;
  final String? body;
  const ListItem({Key? key, this.name, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name ?? "",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ), // title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              body ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ), // body
        ],
      ),
    );
  }
}
