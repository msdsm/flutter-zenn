import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // httpという変数でhttpパッケージにアクセスするため
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qiita_app/models/article.dart';


class SearchScreen extends StatefulWidget {
    const SearchScreen({super.key});

    @override
    State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Qiita Search'),
            ),
            body: Container(),
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