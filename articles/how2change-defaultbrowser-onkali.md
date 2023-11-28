---
title: "Kali-linux上でデフォルトブラウザを変更する方法"
emoji: "💭"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: [kali-linux]
published: true
---
# はじめに
Kali-Linuxのデフォルトブラウザはデスクトップ上のブラウザ、すなわちFirefoxである。
しかし、個人的にChromiumをデフォルトブラウザとして使いたいので、その方法をまとめる。

# 方法
```shell
$ xdg-settings set default-web-browser chromium.desktop
```
これで、デフォルトブラウザがChromiumに変更される。
他のブラウザに変更したい場合は、`chromium.desktop`の部分を変更すれば良い。
なお、デフォルトブラウザを確認したい場合は以下のコマンドを実行する。
```shell
$ xdg-settings get default-web-browser
```