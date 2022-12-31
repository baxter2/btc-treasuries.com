Rails.application.routes.draw do
  resources :treasuries, only: [:index]
  namespace :treasuries do
    resources :public_companies, only: [:index, :show], param: :permalink
    resources :countries, only: [:index, :show], param: :permalink
    resources :private_companies, only: [:index, :show], param: :permalink
  end
end
