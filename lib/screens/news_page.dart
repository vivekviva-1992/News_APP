

import 'package:flutter/material.dart';
import 'package:news_app/screens/bookmarkpage.dart';
import 'package:news_app/services/api_services.dart';
import 'package:news_app/screens/news_detail.dart';
import 'package:news_app/services/bookmark_service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final BookmarkService _bookmarkService=BookmarkService();
  final NewsService _newsService=NewsService();
  String _selectedCategory='general';
  late Future<List<dynamic>> _newsFuture;
  @override
  void initState(){
    super.initState();
    _newsFuture=_newsService.fetchNews(_selectedCategory);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("News App",style: TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
      DropdownButton<String>(
            value: _selectedCategory,
              items:[
                'general',
                'business',
                'entertainment',
                'health',
                'science',
                'sports',
                'technology'
              ].map((category){
              return DropdownMenuItem(
                  value: category,
                  child: Text(category));
          }).toList(),
              onChanged: (value){
              setState(() {
                _selectedCategory=value!;
                _newsFuture=_newsService.fetchNews(_selectedCategory);
              });
              },
          ),
    ],
      ),
      body: FutureBuilder<List<dynamic>>(
          future: _newsFuture,
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Center(child: Text("Error:${snapshot.error}"),);
            }
            else if(!snapshot.hasData || snapshot.data!.isEmpty){
              return Center(child: Text("No News availble"));
            }
            List<dynamic> articles=snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
                itemBuilder: (context,index){
                final article=articles[index];
                return ListTile(
                leading:article['image']!=null?Image.network(article['image'],width: 100):null,
                  title: Text(article['title']??"No Title"),
                  subtitle: Text(article['description']??"No Description"),
                  trailing: IconButton(
                    icon:
                        Icon(BookmarkService.isBookmarked(article)? Icons.bookmark:Icons.bookmark_border,),
                  onPressed: (){
                      if(BookmarkService.isBookmarked(article)){
                        BookmarkService.removeBookmark(article);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bookmark removed")
                        ),
                        );

                      }
                      else{
                        BookmarkService.addBookmark(article);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bookmark added!")));
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Bookmarkpage(),));
                                        }),
                  onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetail(article: article),
                  ),
                  );
                  },
                );
                },
            );
          }),
    );
  }
}
