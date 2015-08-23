## Dev環境構築手順

1. OS + middleware 設定方法

  https://github.com/bang-tokyo/bang-ops/blob/master/README.rst

2. railsサーバー

  ```
  $ ssh bang-dev01

  $ git clone git@github.com:bang-tokyo/bang-server.git
  $ cd bang-server

  # 以下のようになっていればOK
  $ which ruby
  /usr/local/rbenv/shims/ruby
  $ ruby --version
  ruby 2.1.5p273 (2014-11-13 revision 48405) [x86_64-linux]
  $ which bundler
  /usr/local/rbenv/shims/bundler
  
  $ bundle install
  $ bundle exec rails s -b 0.0.0.0
  ```
  Mac から http://api.localhost.local にアクセス

## production/staging 反映方法

```
# staging
bundle exec cap staging deploy

# production
bundle exec cap productoin deploy

# branch指定して反映する場合
BRANCH=feature/xxx bundle exec cap staging deploy
```