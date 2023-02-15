import 'package:big_news_project/data/api/api.dart';
import 'package:big_news_project/data/di/di.dart';
import 'package:big_news_project/data/model/category_model.dart';
import 'package:big_news_project/data/model/post_model.dart';
import 'package:big_news_project/pages/info_page.dart';
import 'package:flutter/material.dart';
class DrawerList extends StatefulWidget {
  final Function(int) onDataReceived;

  const DrawerList({Key? key, required this.onDataReceived}) : super(key: key);

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  final AppApi api = di.get<AppApi>();
  List<Categories> categories = <Categories>[];
  List<Post> posts = <Post>[];
  int categoryId = 14;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    setState(() {});
    try {
      var response = await api.getCategories();
      categories = response;
      var responce = await api.getPost(categoryId);
      posts =responce;

      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox(
        height: 500,
        width: double.infinity,
        child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () { widget.onDataReceived.call(categories[index].id);

                  Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) {
                  //       return drawerItemScreen(context, index);
                  //     }
                  //     )
                  // );
                },
                child: CategoryItem(
                  category: categories[index],
                ),
              );
            }),
      );
    });
  }

   drawerItemScreen(BuildContext context, int index) {
    return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: Scaffold(
                          appBar: AppBar(

                            backgroundColor: Colors.white,
                            leading: IconButton(
                              iconSize: 20,
                              color: Colors.blue,
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () => Navigator.pop(context),
                            ),
                            title: Text(
                              posts[index].categoryName.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
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

class CategoryItem extends StatelessWidget {
  final Categories category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                category.name,
                style: const TextStyle(color:Colors.white,fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
            Divider(thickness: 2,)
          ],
        ),
    );
  }
}
