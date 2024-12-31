import 'package:flutter/material.dart';


class NewsDetail extends StatelessWidget {
  final  dynamic article;
  const NewsDetail({Key? key,required this.article}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(article['title']??"New Details"),
      centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (article['image']!=null)
              Image.network(article['image']),
            SizedBox(height: 10),
            Text(article['title']??"No Title",
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(article['content']??"No Content"),
          ],
        ),
      ),


    );
  }
}
