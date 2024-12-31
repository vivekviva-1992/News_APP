
import 'package:flutter/material.dart';
import 'package:news_app/screens/news_detail.dart';
import 'package:news_app/services/bookmark_service.dart';
class Bookmarkpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final bookmarkedArticles=BookmarkService.getBookmarkedArticles();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Bookmarked Articles",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
        centerTitle: true,
      ),
      body: bookmarkedArticles.isEmpty
          ? const Center(child: Text("No Bookmarks"))
          : ListView.builder(

        itemCount: bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = bookmarkedArticles[index];
          return ListTile(
            leading:article['urlToImage']!=null?Image.network(article['urlToImage'],width: 100):null,
            title: Text(article['title'],),
            subtitle: Text(article['description']),
            trailing: IconButton(icon: Icon(Icons.delete),
            onPressed: (){
BookmarkService.removeBookmark(article);
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bookmark removed...")),
);
(context as Element).reassemble();
            },
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetail(article: article),));

            },
          );
        },
      ),
    );
  }
}
