Rails.application.routes.draw do
  constraints subdomain: 'api' do
    namespace :api, path: nil, defaults: {format: :json} do
      namespace :v1 do
        resources :users, only: [:create, :show]

        # user_idをパラメータに持ちたくないので自分の情報の
        # 取得、更新用にme_controllerを用意
        get 'me' => 'me#show'
        put 'me' => 'me#update'
      end
    end
  end
end
