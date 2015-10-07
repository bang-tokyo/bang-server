Rails.application.routes.draw do
  constraints subdomain: 'api' do
    namespace :api, path: nil, defaults: {format: :json} do
      namespace :v1 do
        resources :users, only: [:create, :show]
        get 'users' => 'users#search'

	get 'groups/search' => 'groups#search'
	get 'groups/my'     => 'groups#my'

	resources :groups, except: [:index, :new, :edit] do
	  get 'setting' => 'group_settings#show'
          put 'setting' => 'group_settings#update'
          resources :group_users, only: [:create, :destroy]
        end	

        # user_idをパラメータに持ちたくないので自分の情報の
        # 取得、更新用にme_controllerを用意
        get 'me' => 'me#show'
        put 'me' => 'me#update'
        post 'me/image/' => 'me#upload_image'
        put 'me/location' => 'me#update_location'

        resources :regions, only: [:index]

        get 'bang/request/:id' => 'bang#request_bang'
        get 'bang/reply/:id/:status' => 'bang#reply_bang'
        get 'bang/requests' => 'bang#request_list'
       
        post 'group_bang/request' => 'group_bangs#request_bang'
        post 'group_bang/reply' => 'group_bangs#reply_bang'
        get  'group_bang/requests/:id' => 'group_bangs#request_list'
        
        resources :conversations, only: [:index, :show, :destroy] do
          post 'message' => 'messages#create'
        end
      end
    end
  end
end
