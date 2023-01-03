Rails.application.routes.draw do
  root to: "treasuries#index"
  resources :treasuries, only: [:index]
  namespace :treasuries do
    resources :public_companies, only: [:index, :show], param: :permalink
    resources :countries, only: [:index, :show], param: :permalink
    resources :private_companies, only: [:index, :show], param: :permalink
  end
end
