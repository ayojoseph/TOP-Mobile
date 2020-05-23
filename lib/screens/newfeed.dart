import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overcomers_place/constants.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

final _firestore = Firestore.instance;

class NewsScreen extends StatefulWidget {
//   Widget AppBar = AppBar(title: Text('News Feed'),);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Widget> feedSlivers = [];
  var detailsState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return feedSlivers.length > 0
        ? CustomScrollView(

            slivers: [
              SliverAppBar(
                title: Text('Information Board'),
                floating: true,
                snap: false,
                backgroundColor: kSecondColor,
              ),
              SliverList(
                delegate: SliverChildListDelegate(feedSlivers),
              ),
            ],
          )
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => DetailsPage(
                      title: nTitle, content: nContent, date: nDate)));
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
  DetailsPage({this.title, this.content, this.date});

  final String title;
  final String content;
  final String date;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Information Board'),
          floating: true,
          snap: false,
          backgroundColor: kSecondColor,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
                color: Colors.white,
                child: Text(
              title,
              style: kCardTitleStyle,
            )),
          ]),
        ),
      ],
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
