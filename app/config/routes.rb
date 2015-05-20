Rails.application.routes.draw do
  constraints subdomain: 'api' do
    namespace :api, path: nil, defaults: {format: :json} do
      namespace :v1 do
        resources :users, only: [:create, :show]

        resources :groups, except: [:new, :edit] do
          get 'setting' => 'group_setting#show'
          put 'setting' => 'group_setting#update'
          resources :group_users, only: [:create, :destroy]
        end

        # user_idをパラメータに持ちたくないので自分の情報の
        # 取得、更新用にme_controllerを用意
        get 'me' => 'me#show'
        put 'me' => 'me#update'
        put 'me/location' => 'me#update_location'

        get 'bang/request/:id' => 'bang#request_bang'
        get 'bang/reply/:id/:status' => 'bang#reply_bang'

        resources :conversations, only: [:show]
        resources :messages, only: [:create, :show]
      end
    end
  end
end
