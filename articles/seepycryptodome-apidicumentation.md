---
title: "PyCryptodomeのAPI Documentationを見てみた"
emoji: "⛳"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: ["PyCryptodome"]
published: false
---
# PyCryptodomeとは
Pythonで暗号化を行うためのライブラリです。
CTFでよく使われるので、今回は使い方を調べてみました。
ちなみにインストール方法は単純。
```
pip3 install pycryptodome
``` 
これでインストールできます。

# API Documentation
PyCryptodomeのAPI Documentationは[こちら](https://pycryptodome.readthedocs.io/en/latest/src/api.html)です。
PyCryptodomeには様々なAPIが入っていますが、どうやら以下の8つのPackageに分かれているようです。
| Package | 説明 | 例 |
| ---- | ---- | ---- |
| Crypto.Cipher | 暗号化や復号化を行うためのモジュール | AES |
| Crypto.Signature | デジタル署名を作成したり検証したりするためのモジュール | PKCS#1 v1.5 |
| Crypto.Hash | 暗号学的ハッシュ関数を作成するためのモジュール | SHA-256 |
| Crypto.PublicKey | 公開鍵を生成したりするモジュール | RSA or ECC |
| Crypto.Protocol | 他のモジュールを活用し、安全な通信を行うためのモジュール | Shamir’s Secret Sharing scheme |
| Crypto.IO | 暗号化データに一般に使用される暗号化に対応するためのモジュール | PEM |
| Crypto.Random | ランダムデータを生成するためのモジュール | ---- |
| Crypto.Util | よく使うモジュール | XOR for byte strings |

# Crypto.Cipher
まず、Crypto.Cipherについて見ていきます。
## 概要
最初に暗号について軽い説明があります。
> 暗号化には3つの種類があります。
> - 対称暗号：同じ鍵を暗号化と復号化に使用する暗号。通常非常に高速で大量のデータを処理できる。
> - 非対称暗号：送信者と受信者が異なる鍵を使用する暗号。送信者は公開鍵、受信者は秘密鍵を持つ。通常、対称暗号よりも遅く小さいデータ量しか処理できない。
> - 復号暗号：対称暗号と非対称暗号の組み合わせ。通常、非対称暗号で対称暗号の鍵を暗号化し、対称暗号でデータを暗号化する。
## APIの使用方法
次にAPIの使用方法について説明があります。
Crypto.CipherのAPIは非常に単純で以下の3つがあります。
| API | 説明 |
| ---- | ---- |
| new() | 暗号化や復号化を行うためのオブジェクトを作成する |
| encrypt() | データを暗号化する |
| decrypt() | データを復号化する |

なお、暗号化できる平文は`byte``bytearray``memoryview`の3つのみです。
string型は暗号化できません。
## 暗号方法の種類
そして、使用できる暗号に関する説明があります。
> 対象暗号には2つの種類があります。
> - ストリーム暗号：データを1バイトずつ暗号化する。例として、ChaCha20、XChaCha20、Salsa20がある。
> - ブロック暗号：データを固定長のブロックに分割し、ブロックごとに暗号化する。最も重要なものはAESで、16バイトごとにデータを暗号化する。
> また、対象暗号と認証を組み合わせたものもあります。
> - Modern modes：認証付き暗号化。例として、GCMがある。
> - ストリーム暗号とMAC機能の組み合わせ：例として、ChaCha20-Poly1305やXChaCha20-Poly1305がある。
### Salsa20
Salsa20はDaniel J. Bernsteinによって設計されたストリーム暗号です。
秘密鍵は32バイトが好ましいですが、16バイトでも使用できます。
また、秘密鍵の他に使い捨ての乱数値を必要とします。
実装方法は以下の通りです。
```python
# Crypto CipherからSalsa20をインポート
from Crypto.Cipher import Salsa20

# 暗号化
# 暗号化する平文を用意
plaintext = b'Attack at dawn'

# 秘密鍵を用意
secret = b'*Thirty-two byte (256 bits) key*' # 32バイトの秘密鍵

# 暗号化するためのオブジェクトを作成
cipher = Salsa20.new(key=secret)

# 平文を暗号化 (この時に乱数値を用いる)
msg = cipher.nonce + cipher.encrypt(plaintext)

# 暗号文を表示
print(msg)

# 復号化
# 暗号文を乱数文字列と暗号文に分割
msg_nonce = msg[:8]
cipher_text = msg[8:]

# 復号化するためのオブジェクトを作成
cipher = Salsa20.new(key=secret, nonce=msg_nonce)

# 暗号文を復号化
plaintext = cipher.decrypt(cipher_text)

# 平文を表示
print(plaintext)
```

### ChaCha20 and XChaCha20
ChaCha20はÐaniel J. Bernsteinによって設計されたストリーム暗号です。
秘密鍵は32バイトで、さらに使い捨ての乱数値を必要とします。
乱数値の長さによって、ChaCha20とXChaCha20に分かれます。
| 乱数値長 | 説明 | 最大平文長 | 一つの鍵における作成メッセージ可能数 |
| ---- | ---- | ---- | ---- |
| 8バイト | ChaCha20 | 限界ナシ | 200,000メッセージ |
| 12バイト | RFC7539によって定義されたChaCha20 | 256GB | 130億メッセージ |
| 24バイト | XChaCha20 | 256GB| 限界ナシ | 

#### Crypto.Cipher.ChaCha20.ChaCha20Cipherクラス
- decrypt(ciphertext) : 暗号文を復号化する。引数は暗号文。
- encrypt(plaintext) : 平文を暗号化する。引数は平文。
- seek(position) : 使い方がよくわからない。

#### Crypto.Cipher.ChaCha20.new(**kwargs)クラス
Keyword Argumentsとしてkeyとnonceがある。
- key : 秘密鍵。32バイト。
- nonce : 乱数値。
    - ChaCha20の場合、8バイトあるいは12バイト。
    - XChaCha20の場合、24バイト。
    - 指定されていない場合、8バイトがランダムで生成される。

実装方法は以下の通りです。
```python
import json
from base64 import b64encode, b64decode

# Crypto CipherからChaCha20をインポート
from Crypto.Cipher import ChaCha20
# Crypto Randomからget_random_bytesをインポート
from Crypto.Random import get_random_bytes

# 暗号化
# 平文を用意
plaintext = b'Attack at dawn'

# 秘密鍵を用意
key = get_random_bytes(32) # 32バイトの秘密鍵

# 暗号化するためのオブジェクトを作成
cipher = ChaCha20.new(key=key)

# 平文を暗号化
ciphertext = cipher.encrypt(plaintext)

# 乱数値を生成
nonce = b64encode(cipher.nonce).decode('utf-8')

# 暗号文を64bitエンコード
ct = b64encode(ciphertext).decode('utf-8')

# 乱数値と暗号文を表示
result = json.dumps({'nonce':nonce, 'ciphertext':ct})
print(result)

# 復号化
# 暗号文や乱数値を64bitデコード
try:
    b64 = json.loads(result)
    nonce = b64decode(b64['nonce'])
    ciphertext = b64decode(b64['ciphertext'])

    # 復号化するためのオブジェクトを作成
    cipher = ChaCha20.new(key=key, nonce=nonce)

    # 暗号文を復号化
    plaintext = cipher.decrypt(ciphertext)

    # 平文を表示
    print(plaintext)
except (ValueError, KeyError):
    print("Incorrect decryption")
```

### AES
AESはNISTによって標準化された対象ブロック暗号で、データブロックは16バイトです。
鍵長は16バイト、24バイト、32バイトのいずれかです。
AESで暗号化する際、暗号利用モードを指定できます。
指定できるモードは以下の通りです。
| モード | 説明 |
| ---- | ---- |
| AES.MODE_ECB | Electronic Code Book | 
| AES.MODE_CBC | Cipher Block Chaining |
| AES.MODE_CFB | Cipher FeedBack |
| AES.MODE_OFB | Output FeedBack |
| AES.MODE_CTR | Counter mode|
| AES.MODE_OPENPGP | OpenPGP mode |
| AES.MODE_CCM | Counter with CBC-MAC |
| AES.MODE_EAX | EAX mode |
| AES.MODE_SIV | Synthetic Initialization Vector mode |
| AES.MODE_GCM | Galois Counter mode |
| AES.MODE_OCB | Offset Code Book mode |

実装方法は以下の通りです。
```python
from Crypto.Cipher import AES

# 秘密鍵を用意
key = b'Sixteen byte key' # 16バイトの秘密鍵

# 暗号化するためのオブジェクトを作成
# 今回の暗号利用モードはEAX modeを使用
cipher = AES.new(key, AES.MODE_EAX)

# nonceを生成
nonce = cipher.nonce

# 平文を用意
plaintext = b'Attack at dawn'

# 平文を暗号化
ciphertext, tag = cipher.encrypt_and_digest(plaintext)

# 暗号文とtagを表示
print("Ciphertext:", ciphertext)
print("Tag:", tag)

# 新しい暗号オブジェクトを初期化して復号化
decipher = AES.new(key, AES.MODE_EAX, nonce=nonce)

# 平文を復号化
decrypted_text = decipher.decrypt(ciphertext)

# 復号化された平文を表示
print("Decrypted Text:", decrypted_text.decode())
```
ちなみに、EAXモードは暗号化と認証を組み合わせたモードです。
MAC（Message Authentication Code）が使用されており、鍵とデータを組み合わせてタグを生成し、暗号文とタグを送信するのが特徴です。