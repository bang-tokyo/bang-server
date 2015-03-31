# bang-server

## Dev環境構築手順
1. Vagrantでcentos-6.6を構築

  以下のboxを仕様
  ```
  "chef/centos-6.6"
  ```
2. Vagrantfileの設定変更
  
  以下2つの設定を有効にする
  ```
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  ```
3. Vagrantで作った開発環境に公開鍵を配置

  ```
  $ ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.33.10
  ```
4. ansibleでサーバーセットアップ

  ```
  $ cd bang-server/ansible
  $ ansible-playbook -i develop all.yml
  ```
5. 開発環境のファイアーウォールをOFF(仮対応)

  ```
  $ ssh bang@192.168.33.10
  $ sudo service iptables stop
  $ sudo chkconfig iptables off
  ```
6. railsサーバー

  ```
  $ cd ~/app
  $ bundle exec rails s -b 0.0.0.0
  ```
  http://localhost:3000にアクセス
