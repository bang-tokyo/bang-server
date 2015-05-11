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
      end
    end
  end
end
