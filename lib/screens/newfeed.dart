import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overcomers_place/constants.dart';
import 'package:intl/intl.dart';



final _firestore = Firestore.instance;

class NewsScreen extends StatefulWidget {
//   Widget AppBar = AppBar(title: Text('News Feed'),);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  List<Widget> feedSlivers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getNews();

  }
  @override
  Widget build(BuildContext context) {
    return feedSlivers.length > 0 ? CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('News Feed'),
          floating: true,
          snap: false,
          backgroundColor: kSecondColor,
        ),
        SliverList(
          delegate:SliverChildListDelegate(
        feedSlivers
          ),

        ),

      ],
    ) : Center(child: CircularProgressIndicator(),);
  }

  void getNews() async{
    final newData = await _firestore.collection('News').orderBy('date_time').getDocuments();
    List<Widget> news = [];

    for(var post in newData.documents){
      final title = post.data['title'];
      final content = post.data['content'];
      final date = DateFormat.yMMMd().format(post.data['date_time'].toDate());
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));
      news.add(NewsCard(nTitle: title,nContent: content,nDate: date.toString(),));

    }

    setState(() {
      feedSlivers = news;
    });

//    print(newData.documents[0].data);
  }

  Widget appbar(){
    return AppBar(title: Text('News Feed'),);
  }
}


class NewsCard extends StatelessWidget {

  NewsCard({this.nTitle, this.nContent, this.nDate});

  final String nTitle;
  final String nContent;
  final String nDate;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(nContent),
      ),

    );
//  return Text(nTitle);
  }
}


class FeedStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('News').orderBy('date_time',descending: false).snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final FeedNews = snapshot.data.documents.reversed;
          List<Widget> newsWidgets = [];
          for(var news in FeedNews){
            final newsTitle = news.data['title'];
            final newsContent = news.data['content'];

            final newsTile = Text('$newsTitle  $newsContent',style: TextStyle(fontSize: 100),);

            newsWidgets.add(newsTile);
          }
          return Expanded(
            child: ListView(
              children: newsWidgets,
            ),
          );

//        return newsWidgets;


        }

      },
    );
  }
}

//return NestedScrollView(
//headerSliverBuilder: (BuildContext context,bool innerBoxisScrolled){
//return <Widget>[
//SliverAppBar(
//title: Text('News Feed'),
//floating: true,
//snap: false,
//backgroundColor: kSecondColor,
//
//)
//];
//},
//body: Container(
//color: kBaseColor,
//child: FeedStream(),
//),
//
//);


