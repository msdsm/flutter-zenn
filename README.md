# いちから始めるFlutterモバイルアプリ開発

## ソース
- https://zenn.dev/heyhey1028/books/flutter-basics/viewer/about_flutter


## メモ
### ウィジットとは


### Dartとは
- Googleが開発したプログラミング言語
- 以下の特徴を持つ
  - 静的型付け言語
  - オブジェクト指向言語
- 静的であるため以下のように書ける
```dart
final int number = 10;
final String kazu = '10';

void myFunction(int data){
    // do something
}

void main(){
    myFunction(int); // OK
    myFunction(kazu); // NG
}
```
- しかし、`dynamic`というキーワードを使うと動的型付けもできる
```dart
final int number = 10;
final String kazu = '10';

void myFunction(dynamic data){
    // do something
}

void main(){
    myFunction(int); // OK
    myFunction(kazu); // OK
}
```
- OOPであるため以下のようにオブジェクトの継承などが可能
```dart
// スーパークラスを定義する
class Vehicle {
  String model;

  Vehicle(this.model);

  void start() {
    print('Vehicle $model has started!');
  }
}

// サブクラスを定義する
class Car extends Vehicle {
  int year;

  Car(String model, this.year) : super(model);

  @override
  void start() {
    print('Car $model has started!');
  }
}

void main(){
  // インスタンスを作成する
  Car car = Car('Toyota', 2019);
  // 継承を使ってスーパークラスとサブクラスのメソッドを呼び出す
  car.start();  // Car Toyota has started!
}
```
- また関数型プログラミングの機能もある
- 以下のように変数に関数を代入できる
```dart
// 関数を定義する
int double(int x) {
  return x * 2;
}

// 関数を実行する
int answer = double(2);
print(answer); // 4

// 関数を別の変数に代入する
Function myFunction = double;

// 関数を実行する
int result = myFunction(3);
print(result); // 6
```

### DartPadとは
- Webブラウザ上でDartプログラムを記述して即座に実行できるオンラインツール

### Dartの変数定義
- `修飾子 データ型 変数名`で書く
```dart
const int number = 150;
var String words;
words = myFunction(); // 動的
```
- データ型はオプショナルであるため書かなくてもエラーにならない

### Dartのデータ型
- 以下のようなデータ型がある
  - `String` : 文字列(シングルクオートもダブルクオートも使える)
  - `int` : 整数値
  - `double` : 実数
  - `bool` : 真偽値
  - `List` : 配列
  - `Set` : 集合
  - `Map` : 連想配列
  - `Function` : 関数
  - `null`
- 以下、例
```dart
final String name = 'John';
final String hello = "Hi, I'm John!";
final int age = 39;
final double height = 180.3;
final bool isMarried = true;
```
- 以下、`List`, `Set`, `Map`の例
```dart
// String型を格納するList
const List<String> fruits = ['りんご','バナナ','みかん'];

// int型を格納するSet
final Set<int> countryCodes = {1,81,44,82,86,886};

// keyがString型、valueがint型のデータを格納するMap
final Map<String,int> students = {'佐藤':5, '伊藤':3};
```
- 以下、Functionの例
```dart
// int型の引数を取り、String型の値を返す関数を格納
final String Function(int) myFunc = myFunction;
```
- 文字列に変数を埋め込むのは`${}`でいける
```dart
// 変数を埋め込む
final int age = 39;
final String message = "Hi, I'm $age years old";
print(message)
// output: Hi, I'm 39 years old

// アクセスしたオブジェクトの値を埋め込む
final Map<String,dynamic> info = {'name':'Blake', 'age':16};
final String greeting = "my name is ${info['name']}. I'm ${info['age']} years old.";
print(greeting);
// output: my name is Blake. I'm 16 years old.

// 関数の返り値を埋め込む
String sayMyFavoriteFruit(){
    return 'peach';
}
final String introduction = 'I like ${sayMyFavoriteFruit()}.';
print(introduction);
// output: I like peach.
```
- `null`を許容する変数であることを明示するために、データ型の後ろに`?`をつける
```dart
final String? result = myFunction();
```

### Dartの修飾子
- `var` : 変数
- `final` : インスタンス生成時に代入される定数
- `const` : コンパイル時に代入される定数
- `var`では以下のように何度も上書き可能
```dart
var int data = 0;
print(data);

data = 15;
print(data) // 何度上書きしてもOK
```
- `const`はコンパイル時に代入される定数であるため、動的な値の代入ができない
```dart
const int data = 20;
print(data); // output:20

data = 15; // 上書きはNG

const int number = myFunction(); // 動的な値はNG
```
- `final`はインスタンス生成時に代入されるため、動的な値なども代入可能
```dart
final String data = 'John';
print(data) // output: John

data = 'Bob'; // 上書きはNG

final String name = myName(); // 動的な値もOK
```

### Dartの関数
- 以下のように普通に書く
```dart
String myFunction(int number){
    return number.toString();
}

void sayHello(){
    print('Hello World!!');
    return;
}
```
- アロー関数もかける
```dart
void sayHello() => print('Hello World!!');
```
- 非同期関数は、`async {}`と書いて返り値を`Future`というデータ型にする
```dart
// ex. APIを呼び出し、レスポンスを受け取るまで処理を待つ関数
Future<String> callApiFunction(int countryCode) async {
    return await getWeatherFromAPI(countryCode);
}
```
- 呼び出す側も非同期関数にする必要がある
```dart
Future<void> main() async {
    final weather = await callApiFunction(81);
}
```
- 引数を`{}`で囲うと名前付き引数を受け取る関数を定義できる
  - 必須であれば`required`をつけて、必須でなければ`null`許容型`?`にする
```dart
// 引数が必須の関数
String mySecondFunction({required int age}){
    return age.toString();
}

// 引数が必須ではない関数
void myThirdFunction({int? age}){
    print(age);
    print('Age might be null');
}

// 呼び出し
void main(){
   final String result = mySecondFunction(age:18);
}
```

### Dartのクラス
- 以下のように書ける
```dart
class MyClass {
  // フィールド
  int _a;
  String _b;

  // ゲッター
  int get a => _a;
  String get b => _b;

  // セッター
  set a(int value) => _a = value;
  set b(String value) => _b = value;

  // コンストラクタ　
  // 引数がそのままフィールドに代入される
  MyClass(this._a, this._b);

  // Factoryコンストラクタ
  factory MyClass.fromJson(Map<String, dynamic> json) {
    return MyClass(json['a'], json['b']);
  }

  // メソッド
  void printValues() {
    print('a = $_a, b = $_b');
  }

  // staticメンバ
  static int myInt = 20;
  static void myFunc() {
    print('static var is $myInt');
  }
}

// 呼び出し(インスタンス化)
void main(){

    final MyClass myClass = MyClass(10, 'hello');

    print(myClass.a); // output: 10
    print(myClass.b); // output: hello
    myClass.printValues(); // output:a = 10, b = hello

    print(MyClass.myInt); // output: 20
    MyClass.myFunc(); // output: static var is 20
}
```
- 変数名の先頭にアンダースコア`_`を付けることでプライベート変数化できる
```dart
void myGlobalFunction(){
    print('This is global');
}

void _myPrivateFunction(){
    print('This is private');
}

void myFunction(){
        myGlobalFunction(); // OK
        _myPrivateFunction(); // OK：同一ファイル内の為アクセス可能
}
```
### Fractoryコンストラクタ
- `factory`を用いてインスタンス化の際に複雑な処理が可能
  - 自由に引数を受け取りインスタンスを返すことができる
```dart
// Factoryコンストラクタ
factory MyClass.fromJson(Map<String, dynamic> json) {
  return MyClass(json['a'], json['b']);
}
```

### `for in`
- 配列やマップを回す
- pythonのfor文やC#のforeach
```dart
// Listの中身を取り出す
List <int> numbers = [1, 2, 3, 4, 5];
for (int n in numbers) {
  print(n);
}

Map<int, String> myMap = {81: 'JP', 1:'US', 44:'GB'};
// keyのみを取り出す
for (int key in myMap.keys) {
  print(key);
}
// valueのみを取り出す
for (var value in myMap.values) {
  print(value);
}
// keyとvalueどちらにもアクセス
for (var entry in myMap.entries) {
  print('Key: ${entry.key}, Value: ${entry.value}');
}
```

### 例外処理
- `try`, `catch`, `finally`, `throw`を以下のように使える
```dart
try{
  print("try block");
  throw Error();
} on AppError catch(error, stackTrace) {
  print('App error captured: $error');
} on PlatformError catch(error, stackTrace){
  print('Platform error captured: $error');
} finally {
  print("finally block");
}
```

### List操作
- `add()`
- `addAll()`
- `remove()`
- `removeWhere()`
- `contains()`
- `any()`
- `every()`
- `where()`
- `firstWhere()`
- `sublist()`
- `indexOf()`
- `indexWhere()`
- `sort()`
- `shuffle()`
- `asMap()`
- `toList()`
- `toSet()`
- `join()`
- `reduce()`
- `fold()`
- `from()`
### Map操作
- `addAll()`
- `addEntries()`
- `remove()`
- `removeWhere()`
- `update()`
- `updateAll()`
- `containsKey()`
- `containsValue()`
- `map()`
- `forEach()`

### Flutterの基本的なコマンド
- `flutter help`
  - flutterコマンド一覧取得
- `flutter create [プロジェクト名]`
  - プロジェクトを作成
- `flutter doctor`
  - Flutter開発で必要とされるツールの設定状況を確認
  - vオプションで詳細情報を表示
- `flutter devices`
  - Flutterアプリを起動する際に使えるデバイスを確認
- `flutter pub add`
  - アプリで使用するパッケージをインストールするコマンド
  - `pubspec.yaml`に依存関係を追加
- `flutter run`
  - アプリを起動するコマンド
  - dオプションでデバイスを指定
  - 起動後に`r`->Enterでリフレッシュ
  - `R`->Enterでホットリロード
- `flutter build`
  - アプリをコンパイル
  - `flutter build apk`でAndroid用のapkファイルをビルド
  - `flutter build ios`でIOS用のファイルをビルド

### シミュレータの設定と起動
#### IOS
- `open -a Simulator`で起動
- Simulator起動後は上のFile->Open Simulatorからデバイス変更が可能
#### Android
- Android Studio起動
- Virtual device manegerクリック
- 既存のデバイスを選択または作成

### Flutterプロジェクト動かし方
- `flutter create`でプロジェクト作成
- Simulator起動
- `flutter devices`でSimulatorのID確認
- プロジェクトに移動して`flutter run -d [id]`を実行
- 立ち上がる
- `flutter run`をCtrl+Cで止めると終了

### Flutterプロジェクトの中身
#### `lib`ディレクトリ
- 実際にアプリのコードを記述するディレクトリ
- `main.dart`がFlutterアプリのエントリーポイント
#### `analysis_options.yaml`
- Dartのコードを解析する際の設定ファイル
#### `ios`, `android`, `web`, `macos`, `linux`, `windows`ディレクトリ
- Platformごとのディレクトリ
- `lib`ディレクトリに記述されたコードを各種platformにたいおうしたコードに変換する際に参照される
#### `pubspec.yaml`, `pubspec.lock`
- Flutterのパッケージ管理に関するファイル
- `pubspec.yaml`にはパッケージの依存関係を記述
- `pubspec.lock`にはその依存関係を解決した結果が記述される
#### `test`ディレクトリ
- Flutterのテストコードを記述
#### `ios`ディレクトリ内
- `ios/Runner/AppDelegate.swift`
  - IOS特有の機能などを使う場合にIOS側に処理の実装が必要な場合がある
  - その場合はこのファイルに記述
- `ios/Runner/Info.plist`
  - 位置情報の取得やBlueToothの使用などユーザーに許可を求める機能を使用する場合にはこのファイルに設定を記述
#### `android`ディレクトリ内
- `android/app/build.gradle`
  - Androidのアプリケーションに関する設定ファイル
  - コンパイルに使うSDKのバージョンやアプリケーションの設定などを記述
- `android/app/src/main/AndroidManifest.xml`
  - 位置情報の取得やBlueToothの使用などユーザーに許可を求める機能を使う場合にこのファイルに設定を記述

### Widget
- FlutterにおいてUIを構成する各要素をWidgetと呼ぶ
- Widgetはツリー構造を取ることでUIを構成
```dart
    ...
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
    ...
```
- この例では以下のようなツリーになっている
- Scaffold
  - AppBar
    - Text
  - Center
    - Column
      - Text
      - Text
  - Floating Action Button
    - Icon

### StatelessWidgetとStatefulWidget
- これらのクラスは`build`メソッドを持っており、このメソッド内でWidgetをreturnすることでWidgetの描画がおこなわれる
- これらは抽象クラスであるため下記のように継承したクラスを定義して`build`メソッドをoverrideする
```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetA(); // WidgetA を描画
  }
}
```
- `StatelessWidget`は状態を持たず`StatefulWidget`は状態を持つ
- `StatefulWidget`は状態が変更されるとUIを更新する
- 下記のカウンタを例にする
- MyHomePageクラスは`StatefulWidget`を継承している
- `createState()`メソッドで`State`クラスを返す
- この`State`クラスが`build()`メソッドを持つ
- この`State`クラス内の変数が変更されるたびに`build()`メソッドを再度呼び出すようになっている
```dart
// StatefulWidgetクラス
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Stateクラス
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### Constraints go down, Size go up
- Widgetのサイズを決定づける要素は以下の2つ
  - 親から子に渡されるConstraints(制約)
  - Widget自身の習性
- Constraintsは制約を意味しておりサイズの最大と最小を設定できる
  - 子Widgetはこの与えられたサイズ領域の中で自身がとるサイズを計算する
```dart
const BoxConstraints({
    this.minWidth = 0.0,
    this.maxWidth = double.infinity,
    this.minHeight = 0.0,
    this.maxHeight = double.infinity,
  }){
    final double minWidth;
    final double maxWidth;
    final double minHeight;
    final double maxHeight;
  }
```
- Widget自身の習性とは、「与えられたサイズ制約の中でどのようにふるまうか」という設定
- この習性は大きく分けて以下の3つ
  - なるべく大きくなろうとする
  - なるべく小さくなろうとする
  - 制約に関係なく特定のサイズになろうとする
- Widgetツリー構築時にツリーのルートからBoxConstraintsを末端のWidgetに達するまで渡していく
- 末端に到達した時点で初めてWidget自身の振る舞いとBoxConstraintsを照らし合わせてサイズを決定する
- 末端から決まった自身のサイズを親Widgetに伝達していき、親Widgetは伝達された子Widgetのサイズｗもとに今度は子Widgetの配置を決める


### `main.dart`の中身
#### `import`
```dart
import 'package:flutter/material.dart';
```
- `material`パッケージはマテリアルデザインのUIコンポーネントを使うためのパッケージ

#### `void main()`
- ファイルを指定して実行すると呼び出されるのが`main`関数
- `flutter run`コマンドでは指定がなければ自動的に`lib/main.dart`が実行される
- `flutter run -t [filename]`とすると実行ファイルを指定でき、この場合はfilename内のmain関数が実行される
```dart
void main() {
  runApp(const MyApp());
}
```

#### `runApp()`
- `runApp()`関数はアプリを構成するWidget群を受け取り描画エンジンにつなげる
- 引数として渡すWidgetがアプリのルート
  - Widgetツリーのルートノード

#### `MyApp`クラス
- `StateessWidget`を継承するクラス
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```
- `build`メソッドをoverrideする形でWidgetを返却
- `MaterialApp`はgoogleが提供するマテリアルデザインに準拠するWidgetとそれらで使う様々な機能を提供してくれるWidget
  - title, themeを指定
    - `ThemeData`はアプリ全体のビジュアルに関するテーマを定義するクラス
      - 大量のフィールドを持つ(今回はcolorScheme,useMaterial3しか指定していないけど)
  - homeフィールドには最初に表示するWidgetを指定する
    - 今回は`MyHomePage`を指定しているのでアプリを立ち上げるとMyHomePageが表示されている

#### `MyHomePage`
- MyHomePageクラスはStatefulWidgetを継承したクラスでこのクラスが返しているWidget群は_MyHomePageStateクラスの`build`メソッドにある
```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
```
- `Scaffold`Widgetはマテリアルデザインのアプリを作る(MaterialAppを使う)場合にページの元となるWidgetのこと
  - 白紙のページのようなもの
  - bodyに渡すWidgetがページの中身
- `AppBar`Widgetは画面上部のアプリバーを表示するWidget
  - titleに渡すWidgetがアプリバーのタイトルになる
- `Center`Widgetは子Widgetを中央に配置するWidget
  - これは`AppBar`の様にUIコンポーネントを描画するWidgetではなくレイアウトのみを行うWidget
- `Column`Widgetは縦に子Widgetを配置するWidget
  - childrenフィールドに複数のWidgetを与えることができ、与えた子Widgetを縦に並べる
- `Text`Widgetは文字列を表示するWidget
  - 第一引数に渡した文字列を表示する
  - フォントや色、サイズなどを指定するフィールドもある
- `FloatingActionButton`Widgetは画面下部の画面の上に浮いたようなボタンを表示するWidget
  - 他にもいくつかのボタンWidgetがある
  - ボタンWidgetはユーザーのタップを検知することができ、タップされた際に実行する処理を`onPressed`フィールドに渡すことができる
- `Icon`Widgetはアイコンを表示するためのWidget

### 画面遷移
- Flutterでは`Navigator`クラスに`Route`クラスでラップしたページを渡すことでページの遷移を行う
- `Navigator`はstack構造になっていてページ遷移するたびにページが積まれていきユーザーはtopのページを見ている
  - そのため遷移してきたページを逆順に戻れる
- 以下はあるページからPageBに遷移するコード
```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => PageB()
  ),
);
```
- `Navigator`クラスの`push`メソッドに`PageB`クラスをラップした`MaterialPageRoute`クラスを渡している
- `MaterialPageRoute`は`Route`クラスを継承したクラスでマテリアルデザインに沿ったページ遷移を行うための`Route`クラス
- `MaterialPageRoute`クラスの`builder`というパラメータはコールバック関数を受け取りその返り値として`Navigator`クラスに渡したいページを指定する
```dart
MaterialPageRoute(
  builder: (context) => PageB(),
),
```
- これを使用してボタンを押すと画面遷移する機能は以下のように書ける
```dart
FloatinActionButton(
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageB(),
      ),
    );
  },
)
```
- ページを追加して遷移する`push()`メソッド以外にも`pop()`,`pushReplacement()`,`pushAndRemoveUntil()`, `popUntil()`などがある

#### `pop()`
- 前のページに遷移するメソッドであり、現在見ているページを破棄する
```dart
Navigator.of(context).pop();
```
- このpop時に値を渡すということも可能
- 値を返す画面へ遷移する際に返り値を受け取る前提で処理を記述すればよい
- 返り値を受け取る処理は非同期処理なので`async`と`await`を使用する
- 値が返されない場合もあるので`nullable`な型にする(`String?`のように)
```dart

// 値を受け取る前提で遷移する
...
onTap: () async {
   final String? result = await Navigator.of(context).push<String?>(
        MaterialPageRoute(
            builder: (context) => PageB(),
        ),
    );
    print(result);
},
...

// 値を持って、前の画面に戻る
Navigator.of(context).pop('戻る際に渡したい値');
```


#### `pushReplacement()`
- 現在のページを新しいページと入れ替えるメソッド
```dart
Navigator.of(context).pushReplacement(
    MaterialPageRoute(
        builder: (context) => PageB(),
    ),
);
```
- 一番上にスタックされている`Route`オブジェクトを新しい`Route`オブジェクトと差し替える

#### `pushAndRemoveUntil()`
- 次のページに遷移しつつ、特定の条件のページまで過去のページを取り除くメソッド
- 第一引数に遷移先の`Route`オブジェクトを渡す
- 第二引数にはコールバック関数を渡す
  - このコールバック関数の引数は`Route`オブジェクト
  - コールバック関数の返り値はboolで、返り値がtrueとなるまで`Route`オブジェクトを取り除き続ける

```dart
// 全ての過去のページを取り除く
Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
        builder: (context) => PageD(),
    ),
    (route) => false,
);

// パス名が'/home'のページに辿り着くまで過去のページを取り除く
Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
        builder: (context) => PageD(),
    ),
    (route) => route.settings.name == '/home',
);
```

#### `popUntil()`
- 指定のページまで一気に戻るメソッド
- 引数にコールバック関数を渡す
  - コールバック関数の引数は`Route`オブジェクト
  - 返り値はboolでtrueを返すまでスタックされている`Route`オブジェクトを取り除く
```dart
// 特定のページまで戻る
Navigator.of(context).popUntil((route) => route.settings.name == '/user');

// 一番最初のページまで戻る
Navigator.of(context).popUntil((route) => route.isFirst);
```

### API呼び出し
- FlutterからAPI通信を行うには`http`パッケージを活用する
- パッケージの追加は`flutter pub add http`
- 使用するファイルで以下のようにimportすればよい
```dart
import 'package:http/http.dart' as http;
```
- PUTメソッドを使う場合は以下のように書ける
```dart
ture<Album> updateAlbum(String title) async {
  final response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update album.');
  }
}
```
- `http.put()`メソッドでPUTメソッド利用
- 第一引数にはエンドポイントを指定
- `headers`でヘッダー情報を指定
- `body`にはMap型でリクエストボディを指定できる
- 得られたresponseは`statusCode`フィールドでステータスコードを参照できる
- レスポンスボディは`body`フィールド
- PUTメソッドと同様にしてGET, POST, PATCH, DELETEも可能
```dart
Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}
Future<http.Response> createAlbum(String title) {
  return http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
}
Future<http.Response> updateUserId(String userId) {
  return http.patch(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userId': userId,
    }),
  );
}
Future<http.Response> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}
```

### `Uri.https()`
- APIのエンドポイントを指定できる
- 第一引数にbaseUrl
- 第二引数にURLパス
- 第三引数にクエリパラメータ
  - `Map<String,dynamic>`型で指定
```dart
final uri = Uri.https('qiita.com', '/api/v2/items', {
    'query': 'title:$keyword',
    'per_page': '10',
});
```

### `Padding` widget
- 余白を作れる
- 余白を追加したいWidgetをPadding widgetで囲めば良い
- `padding`プロパティでいろいろ設定できる
  - `EdgeInsets`を渡すことで指定
  - `EdgeInsets`では上下左右を1つ1つ指定できる
  - 以下の例では垂直、水平にそれぞれ同じ分だけ余白を作る`symmetric()`メソッドを使用

```dart
Padding( // ← Paddingで囲む
  padding: const EdgeInsets.symmetric(
    vertical: 12,
    horizontal: 36,
  ),
  child: TextField(), // TextFieldに余白を作成
),
```

### `TextField` Widget
- テキストボックス
- `style`プロパティに`TextStyle`を渡すことでいろいろ設定できる
- `decoration`プロパティに`InputDecoration`を渡すことでプレースホルダーを指定できる
- `onSubmitted`プロパティにはユーザーがEnterを押した際に発火する処理を指定できる
  - コールバック関数を与える
  - この関数は引数としてTextFieldに記入された文字列を受け取る

```dart
TextField(
  style: TextStyle(
    fontSize: 18,
    color: Colors.black,
  ),
  decoration: InputDecoration( // InputDecorationを渡す
    hintText: '検索ワードを入力してください',
  ),
  onSubmitted: (String value) {
    print(value); // ← 入力された文字列を受け取り処理を実行する
  },
)
```

### `intl`
- `DateTime`の表示を変更できる
- `flutter pub add intl`で追加
```dart
import 'package:intl/intl.dart';
```
- yyyy/MM/dd形式で表示する場合は以下のように`DateFormat`関数を使う
```dart
Text(
  DateFormat('yyyy/MM/dd').format(article.createdAt)
)
```

### `Text` widgetの`overflow`プロパティ
- `Text` widgetには`maxLines`プロパティで行数を限定できる
- この時、表示範囲を超える文字数の場合にどのように表示するかを指定できる`overflow`プロパティがある
- 以下のように指定する
```dart
Text(
  ...
  overflow: TextOverflow.ellipsis,
)
```
- `overflow`で指定できるのは以下
  - `clip` : 行数を超えた文字は表示されない
  - `fade` : 行数を超えた文字は表示されるがフェードアウトする
  - `ellipsis` : 行数を超えた文字は`...`で省略される


### `Column`widgetの`crossAxisAlignment`プロパティ
- どこに寄せるかを指定できる
- `CrossAxisAlignment.end`を指定すると右寄り
- `CrossAxisAlignment.start`を渡すと左寄せ
### `Row` widgetの`mainAxisAlignment`プロパティ
- `Row`の主軸方向にどう子要素を配置するかを指定するプロパティ
- `MainAxisAlignment.spaceBetween`を指定すると幅全部を使って子要素の間には等間隔のスペースを配置する
### `ListView` widget と `Expanded` widget
- `ListView` は`children`プロパティに指定されたWidgetをスクロール可能なリストとして表示する
- `ListView`単体は画面サイズに関わりなく縦方向にどこまでも大きくなろうとする習性があるため、`ListView`は`ListView`に対してサイズ制限を伝えるWidgetで囲う必要がある
- `Expanded`は`Column`や`Row`の中で使われることを前提としたWidgetで、`Column`や`Row`の子要素を並べたときに残っている画面領域を計算してその領域をサイズ制限として自身の子要素につたえる
```dart
Expanded(
  child: ListView(
    children: articles
        .map((article) => ArticleContainer(article: article))
        .toList(),
  ),
),
```


### WebView
- ウェブビューとはアプリ内でブラウザのページを動作させる機能のこと
- 今回の例はQiitaのページをアプリ内から閲覧できるようにする
- `flutter pub add webview_flutter`
```dart
import 'package:webview_flutter/webview_flutter.dart';
```
- 以下のように`WebViewController`インスタンスを渡す形で`WebView` Widgetを利用する
- controllerを作成する際に`loadRequest`メソッドでURL指定する

### `late`
- 遅延初期化するために使用される
- 変数の宣言時には初期化を指定せずに後から初期化を行う
- 変数の初期化を実際にその変数が使われるタイミングに遅らせる

### カスケードオペレータ`..`
- 同じオブジェクトに対して複数の操作を連続して行うことができる
- カスケードオペレータの簡単な例
```dart
var list = <int>[]
  ..add(1)
  ..add(2)
  ..add(3);
// listは[1, 2, 3]を持つ

// カスケードオペレータを使わないとこうなる
var list = <int>[];
list.add(1);
list.add(2);
list.add(3);
```

### `GestureDetector` Widget
- 子要素に対してタップイベントを実装するためのWidget
- `onTap`パラメータにタップされた際の処理を定義することができる
```dart
child: GestureDetector( // GestureDetectorでContainerを囲う
  onTap: () {},
  child: Container(
    ...
  ),
),
```
- 今回は以下のようにしてタップ時に画面遷移を実装
```dart
child: GestureDetector(
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => ArticleScreen(article: article)),
      ),
    );
  },
  child: Container(
    ...
  ),
),
```