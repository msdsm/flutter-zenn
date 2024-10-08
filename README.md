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