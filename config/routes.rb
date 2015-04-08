Rails.application.routes.draw do
  devise_for :users
  resource :transfers, only: [:new, :create]
end
