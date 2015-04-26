describe 'Routing', type: :routing do
  let(:host) { 'http://api.example.com' }

  context 'グループに関するAPI' do
    # グループ登録
    describe "POST '/v1/groups'" do
      subject { {post: "#{host}/v1/groups"} }
      it { is_expected.to be_routable.and route_to(controller: 'api/v1/groups', action: 'create', format: :json, subdomain: 'api') }
    end

    # グループ一覧取得
    describe "GET '/v1/groups'" do
      subject { {get: "#{host}/v1/groups"} }
      it { is_expected.to be_routable.and route_to(controller: 'api/v1/groups', action: 'index', format: :json, subdomain: 'api') }
    end

    # グループ情報取得
    describe "GET '/v1/groups/:id'" do
      subject { {get: "#{host}/v1/groups/:id"} }
      it { is_expected.to be_routable.and route_to(controller: 'api/v1/groups', action: 'show', format: :json, subdomain: 'api', id: '1') }
    end

    # グループ情報更新
    describe "PUT '/v1/groups/:id'" do
      subject { {put: "#{host}/v1/groups/:id"} }
      it { is_expected.to be_routable.and route_to(controller: 'api/v1/groups', action: 'update', format: :json, subdomain: 'api', id: '1') }
    end

    # グループ情報削除
    describe "DELETE '/v1/groups/:id'" do
      subject { {delete: "#{host}/v1/groups/:id"} }
      it { is_expected.to be_routable.and route_to(controller: 'api/v1/groups', action: 'destroy', format: :json, subdomain: 'api', id: '1') }
    end

    context 'グループ設定に関するAPI' do
      # グループ設定情報更新
      describe "PUT '/v1/groups/:group_id/setting'" do
        subject { {put: "#{host}/v1/:group_id/setting"} }
        it { is_expected.to be_routable.and route_to(controller: 'api/v1/groups', action: 'update', format: :json, subdomain: 'api', group_id: '1') }
      end

      # グループ設定情報取得
      describe "GET '/v1/groups/:group_id/setting'" do
        subject { {get: "#{host}/v1/:group_id/setting"} }
        it { is_expected.to be_routable.and route_to(controller: 'api/v1/groups', action: 'show', format: :json, subdomain: 'api', group_id: '1') }
      end

    end

    context 'グループユーザーに関するAPI' do
      # グループユーザー登録
      describe "POST '/v1/groups/:group_id/group_users'" do
        subject { {post: "#{host}/v1/:group_id/group_users"} }
        it { is_expected.to be_routable.and route_to(controller: 'api/v1/groups', action: 'update', format: :json, subdomain: 'api', group_id: '1') }
      end

      # グループユーザー一覧
      describe "GET '/v1/groups/:group_id/group_users'" do
        subject { {get: "#{host}/v1/:group_id/group_users"} }
        it { is_expected.to be_routable.and route_to(controller: 'api/v1/groups', action: 'index', format: :json, subdomain: 'api', group_id: '1') }
      end

      # グループユーザー削除
      describe "DELETE '/v1/groups/:group_id/group_users/:id'" do
        subject { {delete: "#{host}/v1/:group_id/group_users/:id"} }
        it { is_expected.to be_routable.and route_to(controller: 'api/v1/groups', action: 'index', format: :json, subdomain: 'api', group_id: '1', id: '1') }
      end

    end

  end

end