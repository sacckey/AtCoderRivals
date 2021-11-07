# AtCoder Rivals
[![Ruby](https://github.com/sacckey/AtCoderRivals/actions/workflows/ruby.yml/badge.svg)](https://github.com/sacckey/AtCoderRivals/actions/workflows/ruby.yml)

<a href="https://atcoder.jp/" target="_break"> AtCoder</a>のコンテストでのパフォーマンスやレート遷移、日々の精進などをライバルたちと比較し、モチベーション向上に繋げるためのアプリです。<br>
フォローしたユーザーの最近の提出とコンテスト成績を見ることができます。

## How to use
```
$ git clone https://github.com/sacckey/AtCoderRivals.git
$ cd AtCoderRivals
$ docker-compose up
$ docker-compose exec web rails db:create
$ docker-compose exec web rails db:migrate
$ docker-compose exec web rails db:seed
```

サーバー起動後、http://localhost:3000/ にアクセスすることで、アプリケーションを動かすことができます。<br>
※Twitter認証によるログイン機能は使えません。
