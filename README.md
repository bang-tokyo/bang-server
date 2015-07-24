## Dev環境構築手順
1. init.shの実行

  以下のコマンドを実行
  ```
  sh ./setup/init.sh
  ```
2. Vagrantでcentos-6.6を構築

  以下のboxを仕様
  ```
  "chef/centos-6.6"
  ```
3. Vagrantfileの設定変更
  
  以下2つの設定を有効にする
  ```
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  ```
4. Vagrantで作った開発環境に公開鍵を配置

  ```
  $ ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.33.10
  ```
5. ansibleでサーバーセットアップ

  ```
  $ cd bang-server/ansible
  $ ansible-vault decrypt conf.yml
  $ ansible-playbook -i develop all.yml
  ```
6. 開発環境のファイアーウォールをOFF(仮対応)

  ```
  $ ssh bang@192.168.33.10
  $ sudo service iptables stop
  $ sudo chkconfig iptables off
  ```
7. railsサーバー

  ```
  $ cd ~/app
  $ bundle exec rails s -b 0.0.0.0
  ```
  http://localhost:3000にアクセス
  
  apiサブドメインに対応するためmac側の/ete/hostsに設定追加
  ```
  127.0.0.1 api.localhost.local
  ```
