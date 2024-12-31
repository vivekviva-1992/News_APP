
class BookmarkService{
 static final List<Map<String,dynamic>> _bookmarkedArticles=[];
 static List<Map<String,dynamic>>
 getBookmarkedArticles(){
   return _bookmarkedArticles;
 }
 static void addBookmark(Map<String,dynamic>article)
 {
   if(!_bookmarkedArticles.contains(article)){
     _bookmarkedArticles.add(article);
   }
 }
 static void removeBookmark(Map<String,dynamic>article){
   _bookmarkedArticles.remove(article);
 }
 static bool isBookmarked(Map<String,dynamic>article){
   return _bookmarkedArticles.contains(article);
 }
 }
