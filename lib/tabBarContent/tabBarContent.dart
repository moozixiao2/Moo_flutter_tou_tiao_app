import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_toutiao_app/module/request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_toutiao_app/news/moduel/article.dart';

class TabBarContent extends StatefulWidget {
  final int id;

  TabBarContent(this.id);

  @override
  _TabBarContentState createState() => _TabBarContentState();
}

class _TabBarContentState extends State<TabBarContent> {

  List<Article> _list = [];

  _getData () async {
    Response response = await dio.get("http://ttapi.research.itcast.cn/app/v1_1/articles", queryParameters: {"channel_id": widget.id, "timestamp": "1583484886724", "with_top": 0});

    // var data = await RequestModule.httpRequest('get', '/user/articles', null);
    // print(response.data['data']['results']);

    // 数据序列化实例化
    List jsonList = response.data['data']['results'];
    List jsonData = jsonList.map((e) => Article.fromJson(e)).toList();
    // print(jsonData); 
    setState(() {
      _list = jsonData;
    });
  }  

  @override
  void initState() {
    // TODO: implement initState
    // print('/articles/${widget.id}');
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return NewsItem(_list[index]);
        },
      )
    );
  }
}

class NewsItem extends StatelessWidget {

  final Article article;

  NewsItem(this.article);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        article.imgType == 1 ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                '${article.title}',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(
              width: 110.0,
              height: 100.0,
              child: Image.network(
                '${ article.images[0] }',
                fit: BoxFit.cover,
              ),
            )
          ],
        ) : Text(
          '${article.title}',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        article.imgType == 3 ? Row(
          children: article.images.map((val) => Expanded(
              child: AspectRatio(
                aspectRatio: 1/1,
                child: Image.network(
                  val,
                  fit: BoxFit.cover,
                ),
              ),
            )).toList(),
        ) : SizedBox(),
        SizedBox(
          height: 3.0,
        ),
        RichText(
          text: TextSpan(
            text: '${article.isTop == 1 ? '置顶  ' : ''}',
            style: TextStyle(
              color: Colors.red
            ),
            children: [
              TextSpan(
                text: '${article.autName}  ',
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              TextSpan(
                text: '${article.commCount}评论  ',
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              TextSpan(
                text: '1小时前',
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
            ]
          ),
        ),
        Divider(height: 22.0,),
      ],
    );
  }
}

// ListView(
//   children: <Widget>[
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           '一二三四五六七八九十',
//           style: TextStyle(
//             fontSize: 18.0,
//             color: Colors.black
//           ),
//         ),
//         SizedBox(
//           height: 3.0,
//         ),
//         RichText(
//           text: TextSpan(
//             text: '置顶  ',
//             style: TextStyle(
//               color: Colors.red
//             ),
//             children: [
//               TextSpan(
//                 text: '作者  ',
//                 style: TextStyle(
//                   color: Colors.grey
//                 ),
//               ),
//               TextSpan(
//                 text: '评论88  ',
//                 style: TextStyle(
//                   color: Colors.grey
//                 ),
//               ),
//               TextSpan(
//                 text: '1小时前',
//                 style: TextStyle(
//                   color: Colors.grey
//                 ),
//               ),
//             ]
//           ),
//         )
//       ],
//     ),
//     Divider(height: 22.0,),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           '一二三四五六七八九十',
//           style: TextStyle(
//             fontSize: 18.0,
//             color: Colors.black
//           ),
//         ),
//         SizedBox(
//           height: 5.0,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: AspectRatio(
//                 aspectRatio: 1/1,
//                 child: Image.network(
//                   'https://n.sinaimg.cn/blog/267/w180h87/20200306/dc4a-iqmtvwv2642890.jpg',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: AspectRatio(
//                 aspectRatio: 1/1,
//                 child: Image.network(
//                   'https://n.sinaimg.cn/blog/267/w180h87/20200306/772d-iqmtvwv2621956.jpg',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: AspectRatio(
//                 aspectRatio: 1/1,
//                 child: Image.network(
//                   'https://n.sinaimg.cn/blog/267/w180h87/20200306/52cc-iqmtvwv2633953.jpg',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 5.0,
//         ),
//         RichText(
//           text: TextSpan(
//             text: '置顶  ',
//             style: TextStyle(
//               color: Colors.red
//             ),
//             children: [
//               TextSpan(
//                 text: '作者  ',
//                 style: TextStyle(
//                   color: Colors.grey
//                 ),
//               ),
//               TextSpan(
//                 text: '评论88  ',
//                 style: TextStyle(
//                   color: Colors.grey
//                 ),
//               ),
//               TextSpan(
//                 text: '1小时前',
//                 style: TextStyle(
//                   color: Colors.grey
//                 ),
//               ),
//             ]
//           ),
//         )
//       ],
//     ),
//     Divider(height: 22.0,),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 '一二三四五六七八九十十九八七六五四三二一',
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: Colors.black
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 110.0,
//               height: 100.0,
//               child: Image.network(
//                 'https://n.sinaimg.cn/blog/267/w180h87/20200306/52cc-iqmtvwv2633953.jpg',
//                 fit: BoxFit.cover,
//               ),
//             )
//           ],
//         ),
//         SizedBox(
//           height: 5.0,
//         ),
//         RichText(
//           text: TextSpan(
//             text: '置顶  ',
//             style: TextStyle(
//               color: Colors.red
//             ),
//             children: [
//               TextSpan(
//                 text: '作者  ',
//                 style: TextStyle(
//                   color: Colors.grey
//                 ),
//               ),
//               TextSpan(
//                 text: '评论88  ',
//                 style: TextStyle(
//                   color: Colors.grey
//                 ),
//               ),
//               TextSpan(
//                 text: '1小时前',
//                 style: TextStyle(
//                   color: Colors.grey
//                 ),
//               ),
//             ]
//           ),
//         )
//       ],
//     )
//   ],
// )