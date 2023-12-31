---
title: "polylux ～Typstでスライドを作ろう！！～"
emoji: "📝"
type: "tech"# tech: 技術記事 / idea: アイデア
topics: ["Typst", "polylux", "スライド"]
published: true
---
# はじめに
スライドを作るときには、PowerPointを使うことが多いと思いますが、組版システムを用いてスライドを作りたい、という人もいると思います。
代表的な組版システムは、LaTeXですが、LaTeXはコードを書くのが大変、そもそも環境構築が難しいので、挫折をしてしまった人も少なくないでしょう。

「LaTeXは苦手だけど、コードを書いてスライドを作りたい……」、今回はそんな方にオススメ、[Typst](https://github.com/typst/typst)という組版システムのスライド作成パッケージ、[polylux](https://github.com/andreasKroepelin/polylux)を使ってスライドを作成する方法を紹介します。
https://github.com/typst/typst
https://github.com/andreasKroepelin/polylux

# Typstとは？
「そもそもTypstって何？」という方のために、Typstについて簡単に説明します。
Typstは2023年3月に公開された新しい組版システムです。
LaTeXよりも直感的にコードを書くことができ、環境構築も簡単なので、LaTeXが苦手な人にもオススメです。  
詳細は[@sunny](https://zenn.dev/yuhi_ut)さんの記事「[もうTeXは時代遅れ！？ はじめてのTypstマニュアル](https://zenn.dev/yuhi_ut/articles/how2start-typst)」を参照してください。
https://zenn.dev/yuhi_ut/articles/how2start-typst

:::message
以下では既にTypstのインストール・環境構築が完了していることを前提に進めます。
:::

# polyluxを用いてスライドを作成する
polyluxはTypstのスライド作成パッケージです。
このパッケージを導入すれば、Typstのコードを書くだけでスライドを作成することができます。

## polyluxのインポート
ここでは、具体的にどのようにしてpolyluxをインポートして使うかを説明します。
結論は簡単で、typファイルの1行目に以下を付け加えればいいです。 
```
#import "@preview/polylux:0.3.1": *
```
これでpolyluxを使ってTypstのスライドを作成することができます。

## スライドの基本設定
polyluxをインポートしたら、次にスライドの基本設定（紙面の比率、紙の色、字の大きさ、フォント）を行います。
基本設定をする方法は以下の二つがあります。
* 全て自分で設定する。
* Typstにあるテーマを使う。

今回は前者の自分で設定する方法を紹介します。

### 紙面の比率
スライドの縦横の比率は以下のように設定します。
```
#set page(paper: "presentation-16-9")
```
上記は最近の主流である16:9の比率でスライドを作成する場合の設定です。
4:3を使いたい場合は`"presentation-4-3"`とします。

### 紙の色
スライドの背景色は以下のように設定します。
```
#set page(fill: red)
```
上記は背景色を赤に設定する場合の設定です。
背景色の明度を変更したい時は色の後ろに`.lighten(x%)`と付けることで明度を変更することができます。
```
#set page(fill: blue.lighten(80%))
```
背景色を白にしたい場合は特に設定しなくて大丈夫です。

### 字の大きさ
字の大きさは以下のように設定します。
```
#set text(size: 25pt)
```
大体20pt～30ptが良いでしょう。

### フォント
字のフォントは以下のように設定します。
```
#set text(font: "Noto Sans CJK JP")
```

## スライドを作ってみよう
基本設定が終わったらいよいよスライドを作っていきます。
スライドの作り方も簡単です。
```
#polylux-slide[
    Hello, World!
]
```
<!-- ![](/images/hello_world.png) -->

`#polylux-slide`の中に書いた文章がスライドに表示されます。
タイトルスライドにしたい場合は以下のようにするのが良いでしょう。
```
#polylux-slide[
    #set align(horizon + center)
    = polyluxのススメ

    Lyle
]
```
これでpolyluxを用いてスライドを作成することができるようになりましたね。
最後に全てを合わせたコードを載せておきます。
```
#import "@preview/polylux:0.3.1": *　// polyluxのインポート
#set page(paper: "presentation-16-9", fill: green.lighten(90%))     // スライドの紙面の基本設定
#set text(size: 25pt, font: "Noto Sans CJK JP")     // スライドの字の基本設定

// タイトルスライド
#polylux-slide[
    #set align(horizon + center)
    = polyluxのススメ

    Lyle
]

// 2枚目
#polylux-slide[
    == はじめに

    Typstは組版システムです。
]

// 3枚目
#polylux-slide[
    == 最後に

    ぜひTypstを使ってみてください。
]
```

# 最後に
polyluxを用いたスライド作成法、いかがだったでしょうか？
Typstとpolyluxを使えば、コードを書くだけでスライドを作成することができます。
今回は本当に基本的事項しか扱いませんでしたが、polyluxには更にスライド作成に便利な機能`#uncover`や数種類のテーマなどがあります。
そちらの解説記事もいづれ書いていきたいと思いますので、ぜひTypst、polyluxでスライドを作ってみてください♪