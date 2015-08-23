Rails.application.routes.draw do
  constraints subdomain: 'api' do
    namespace :api, path: nil, defaults: {format: :json} do
      namespace :v1 do
        resources :users, only: [:create, :show]
        get 'users' => 'users#search'

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

        resources :regions, only: [:index]

        get 'bang/request/:id' => 'bang#request_bang'
        get 'bang/reply/:id/:status' => 'bang#reply_bang'
        get 'bang/requests' => 'bang#request_list'

        resources :conversations, only: [:index, :show, :destroy] do
          post 'message' => 'messages#create'
        end
      end
    end
  end
end
