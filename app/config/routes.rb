Rails.application.routes.draw do
  constraints subdomain: 'api' do
    namespace :api, path: nil, defaults: {format: :json} do
      namespace :v1 do
        resources :users, only: [:create, :show]
        resources :groups, only: [:create, :update, :index, :show]
      end
    end
  end
end
