import 'package:big_news_project/data/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class InfoPage extends StatefulWidget {
  final Post post;
  const InfoPage({Key? key,required this.post}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.post.categoryName.name),
            Spacer(),
            Text(widget.post.postModified,style: TextStyle(fontSize: 14),)
          ],
        ),
         

      ),
      body:SingleChildScrollView(child: Html(data: widget.post.content,)),
    );
  }
}
