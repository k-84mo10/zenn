FROM node:latest

# 作業ディレクトリの設定
WORKDIR /zenn

# Zenn CLI をグローバルインストール
RUN npm init --yes
RUN npm install -g zenn-cli

# デフォルトのエントリポイント（コンテナ起動時にzennが利用可能）
CMD [ "bash" ]

