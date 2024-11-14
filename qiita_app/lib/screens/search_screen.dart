import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // httpという変数でhttpパッケージにアクセスするため
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/models/user.dart';
import 'package:qiita_app/widgets/article_container.dart';


class SearchScreen extends StatefulWidget {
    const SearchScreen({super.key});

    @override
    State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
    List<Article> articles = []; // 検索結果を格納する変数(state)

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Qiita Search'),
            ),
            body: Column(
                children: [
                    // 検索ボックス
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 36,
                        ),
                        child: TextField(
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                hintText: '検索ワードを入力してください',
                            ),
                            onSubmitted: (String value) async {
                                final results = await searchQiita(value);
                                setState(()=>articles = results);
                            },
                        ),
                    ),
                    // 検索結果一覧
                    Expanded(
                      child: ListView(
                        children: articles
                              .map((article) => ArticleContainer(article: article))
                              .toList(),
                      ),
                    ),
                    // 検索結果一覧テスト
                    /*
                    ArticleContainer(
                      article: Article(
                        title: 'テスト',
                        user: User(
                          id: 'qii-taro',
                          profileImageUrl: 'https://firebasestorage.googleapis.com/v0/b/gs-expansion-test.appspot.com/o/unknown_person.png?alt=media',
                        ),
                        createdAt: DateTime.now(),
                        tags: ['Flutter', 'dart'],
                        url: 'https://example.com',
                      ),        
                    ),
                    */
                    //const ArticleContainer(),
                ],
            ),
        );
    }

    Future<List<Article>> searchQiita(String keyword) async {
        // 1. http通信に必要なデータを準備
        // URL, クエリパラメータ設定
        final uri = Uri.https('qiita.com', '/api/v2/items', {
            'query': 'title:$keyword',
            'per_page': '10',
        });
        // アクセストークンの取得
        final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

        // 2. Qiita APIにリクエスト送信
        final http.Response res = await http.get(uri, headers: {
            'Authorization': 'Bearer $token',
        });

        // 3. 戻り値をArticleクラスの配列に変換
        // 4. 変換したArticleクラスの配列を返す
        if (res.statusCode == 200) {
            // レスポンスをモデルクラスへ変換
            final List<dynamic> body = jsonDecode(res.body);
            return body.map((dynamic json) => Article.fromJson(json)).toList();
        } else {
            return [];
        }
    }
}