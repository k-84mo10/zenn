---
title: "Polylux 便利機能\"uncover\"を使おう"
emoji: "📝"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: ["typst", "polylux", "スライド"]
published: false
---
# はじめに
前回の記事「[polylux ～Typstでスライドを作ろう！！～](https://zenn.dev/k_84mo10/articles/how2use-polylux1)」では、Typstのスライド作成パッケージ、Polyluxを使ってスライドを作成する方法を紹介しました。
この記事を読めば誰でもTypstのコードを書くだけでスライドを作成することができるようになったと思います。
https://zenn.dev/k_84mo10/articles/how2use-polylux1
しかし、PowerPointやGoogleSlideなど多くの便利なスライド作成ソフトがある中、「Typstで書ける！」という点だけでPolyluxを使おうと思う人は少ないと思います。
そこで、今回はPolyluxの便利機能の一つである「uncover」を用いたスライド作成方法を紹介していきます！

# uncoverとは？
uncoverは、スライドの中で一部の文字を隠しておき、クリックすると文字が現れるという機能です。
LaTeXのスライド作成パッケージ[Beamer](https://texwiki.texjp.org/?Beamer)のuncoverと同様の機能ですね。
Polyluxでは以下のコマンドでuncoverを使うことができます。
```
#uncover(n)["text"]
```
nは「何番目のクリックで文字を現すか」を表します。