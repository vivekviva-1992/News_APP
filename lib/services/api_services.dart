
import 'dart:convert';
import 'package:http/http.dart' as http;


class NewsService{
 Future<List<dynamic>> fetchNews(String category) async{
   final response=await http.get(Uri.parse("https://gnews.io/api/v4/top-headlines?category=general&lang=en&country=us&max=10&apikey=5c9a61efaa72f37e7216e88e9e048426"),
   );
   if (response.statusCode==200){
     final data=json.decode(response.body);
     print(response.body);
     return data['articles'];
   }
   else{
     throw Exception('Failed to load news');
   }
 }
}