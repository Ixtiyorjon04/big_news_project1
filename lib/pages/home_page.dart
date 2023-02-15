import 'package:big_news_project/data/api/api.dart';
import 'package:big_news_project/data/di/di.dart';
import 'package:big_news_project/data/model/category_model.dart';
import 'package:big_news_project/data/model/post_model.dart';
import 'package:big_news_project/pages/drawer_list.dart';
import 'package:big_news_project/pages/info_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum _Status { Success, Loading, Error }

class _HomePageState extends State<HomePage> {
  final AppApi api = di.get<AppApi>();
  List<Post> posts = <Post>[];
  List<Categories> categoriess = <Categories>[];
  int categoryId = 14;
  _Status state = _Status.Loading;

  void load() async {
    state = _Status.Loading;
    setState(() {});
    try {
      final responce = await api.getPost(categoryId);
      final responceCategoriess = await api.getCategories();
      categoriess = responceCategoriess;
      posts = responce;
      state = _Status.Success;
      setState(() {});
    } catch (e) {
      state = _Status.Error;
      setState(() {});
    }
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Terabayt",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          elevation: 0,
        ),
        drawer: Drawer(
          backgroundColor: Colors.grey,
          child: Column(
            children: [
              DrawerHeader(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            "assets/tera_full_logo.png",
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )),
              DrawerList(onDataReceived: (int id) {
                if (id == 2 || id == 0) {
                  categoryId = 482;
                } else {
                  categoryId = id;
                }
                print(id);
                load();
              }
              )
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return (index % 5 == 0)
                  ? bigItem(posts[index],index)
                  : longItem(posts[index],index);
            }),
      ),
    );
  }




  bigItem(Post post,int index) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => InfoPage(post: posts[index],)));
        },
        child: Container(
          margin: EdgeInsets.all(5),
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: NetworkImage(post.image),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(""),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  post.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  longItem(Post post,int index) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => InfoPage(post: posts[index],)));
        },
        child: Container(
          width: double.infinity,
          height: 140,
          decoration: const BoxDecoration(
              color: Colors.white, boxShadow: [BoxShadow(color: Colors.black)]),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 120,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(
                        post.image,
                      ),
                      fit: BoxFit.fitHeight),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Text(
                        post.title,
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Expanded(
                        child: Row(
                          children: [
                            Text(post.categoryName.name),
                            Spacer(),
                            Text(post.postModified.toString())
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
