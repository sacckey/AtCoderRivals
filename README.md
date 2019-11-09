# AtCoder Rivals
<a href="https://atcoder.jp/" target="_break"> AtCoder</a>のコンテストでのパフォーマンスやレート遷移、日々の精進などをライバルたちと比較し、モチベーション向上に繋げるためのアプリです。<br>
フォローしたユーザーの最近の提出とコンテスト成績を見ることができます。

## How to use
```
$ git clone https://github.com/sackey24/AtCoderRivals.git
$ cd AtCoderRivals
$ bundle install --without production
$ rails db:migrate
$ rails db:seed
```

### Server
```
$ rails server
```

### Crawler
```
クローラー起動
$ bundle exec whenever --update-crontab

クローラー終了
$ bundle exec whenever --clear-crontab
```

サーバー起動後、http://localhost:3000/ にアクセスすることで、アプリケーションを動かすことができます。<br>
※Twitter認証によるログイン機能は使えません。