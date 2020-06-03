import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overcomers_place/constants.dart';
import 'package:provider/provider.dart';
import 'package:overcomers_place/components/states.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

final _firestore = Firestore.instance;

class NewsScreen extends StatefulWidget {
//   Widget AppBar = AppBar(title: Text('News Feed'),);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  static List<Widget> feedSlivers = [];
  var pageState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return feedSlivers.length > 0
        ? (context.watch<NewsPageState>().getState() == 1 ? DetailsPage(data: context.watch<NewsPageState>().getData()): FeedPage(feedSlivers: feedSlivers,) )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  void getNews() async {
    final newData =
        await _firestore.collection('News').orderBy('date_time').getDocuments();
    List<Widget> news = [];

    for (var post in newData.documents) {
      final title = post.data['title'];
      final content = post.data['content'];
      final date = DateFormat.yMMMd().format(post.data['date_time'].toDate());
      news.add(NewsCard(
        nTitle: title,
        nContent: content,
        nDate: date.toString(),
      ));
    }
    setState(() {
      feedSlivers = news;
    });

//    print(newData.documents[0].data);
  }
}

class NewsCard extends StatelessWidget {
  NewsCard({this.nTitle, this.nContent, this.nDate});

  final String nTitle;
  final String nContent;
  final String nDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: GestureDetector(
        onTap: () {
          context.read<NewsPageState>().updateContents(nTitle,nContent,nDate);
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailWidget(title: nTitle, date: nDate, content: nContent)),
          );

//          context.read<NewsPageState>().toggleState();
        },
        child: Card(
          elevation: 8,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  nTitle,
                  style: kCardTitleStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  nContent,
                  style: kCardContentStyle,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
//  return Text(nTitle);
  }
}

class DetailsPage extends StatelessWidget {
  DetailsPage({@required this.data});
  final Map data;
//  final String title;
//  final String content;
//  final String date;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: Text('Information Board'),
          floating: true,
          snap: false,
          backgroundColor: kSecondColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: (){
              context.read<NewsPageState>().toggleState();
            },
          )
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                elevation: 8.0,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        data['title'],
                        style: kCardTitleStyle,
                      ),
                      Text(data['date']),
                      SizedBox(height: 17,),
                      Text(data['content'],style: kCardContentStyle,),

                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class FeedPage extends StatelessWidget {

  FeedPage({this.feedSlivers});

  final List<Widget> feedSlivers;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: Text('Information Board'),
          floating: true,
          snap: false,
          backgroundColor: kSecondColor,
        ),
        SliverList(
          delegate: SliverChildListDelegate(feedSlivers),
        ),
      ],
    );
  }
}


class DetailWidget extends StatelessWidget {

  DetailWidget({this.title,this.date,this.content});
  final String title;
  final String date;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              centerTitle: true,
              title: Text(title),
              floating: true,
              snap: false,
              backgroundColor: kSecondColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white,),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  elevation: 8.0,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(date),
                        SizedBox(height: 17,),
                        Text(content,style: kCardContentStyle,),

                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
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
