# ブラックジャック

- ブラックジャック（カジノディーラーとプレイヤーのトランプを使った対戦型ゲーム）を Ruby のみで再現したゲームです。

## インストール方法

```
$ git clone https://github.com/akko-k/blackjack.git
$ cd blackjack
$ ruby main.rb
```

## 使い方

1. ターミナルで `ruby main.rb` を実行。
2. 画面のメッセージに従い、数値を入力したり Enter キーを押したりする。

## 環境

- ruby 2.7.2

## 説明

- プレイヤーは複数人同時にゲームできますが，各プレイヤーはディーラーと１対１で対戦します。つまり、プレイヤーが複数いる場合には、ディーラーは複数のプレイヤーと同時に勝負をすることになります。今回はプレイヤーは１人としています。

- 各プレイヤーの目標は、21 を超えないように手持ちのカードの点数の合計を 21 に近づけ、その点数がディーラーを上回ることです。

- カードの点数は、カード 2 ～ 10 ではその数字通りの値であり、また、K、Q、J は 10 と数えます。A は、1 と 11 のどちらか、都合のよい方で数えることができます。

- 最初に配られた 2 枚のカードの合計が 21（1 枚は 10、J、Q、K のうちのどれかで、もう 1 枚は A という組み合わせの場合のみ可能）であればブラックジャックです。（3 枚以上のカードの合計が 21 の場合はブラックジャックではありません）

- 合計点数が 21 を超えてしまうことをバーストと呼びます。

## ゲームの流れ

1. プレイヤーが賭け金を決めて支払う。
2. ディーラーがプレイヤーと自分に 2 枚ずつ配る（ディーラーの１枚目は伏せられている）
3. この時点で、プレイヤーが 21 であればブラックジャック(ディーラーもブラックジャックの場合，引き分け)
4. プレイヤーがブラックジャックではない場合，プレイヤーは ヒット（カードをもう１枚引く）か スタンド（カードを引かずにその時点の点数で勝負する）かを選ぶ。21 を超えなければ何回でもヒットすることができる。プレイヤーがバーストしたらその場で負けが確定。
5. プレイヤーが スタンド を選んだら，ディーラーは伏せているカードを表示する。
6. ディーラーは、自分の手が 17 以上になるまでカードを引かなければならず、17 以上になったら、追加のカードを引くことはできない。ディーラーがバーストしたら、スタンドしているプレイヤーの勝ち。
7. 点数を比較して，合計点数が 21 に近いほうが勝ち。
8. 賭け金を精算する。

同フォルダ内にある「ブラックジャック フロー図.jpg」も参考にご覧ください。

## 配当金の計算方法

- プレイヤーの勝ち

  - ブラックジャックの場合 賭け金 × 2.5
  - それ以外の場合 賭け金 × 2

- 引き分け（両者ブラックジャックの場合を含む）

  - 賭け金と同額

- プレイヤーの負け（ディーラーがブラックジャックで勝った場合も含む）
  - 配当金は 0

## 参考

ブラックジャック（Wikipedia）
https://ja.wikipedia.org/wiki/%E3%83%96%E3%83%A9%E3%83%83%E3%82%AF%E3%82%B8%E3%83%A3%E3%83%83%E3%82%AF
