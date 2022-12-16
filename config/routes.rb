Rails.application.routes.draw do
  get 'recommends/index'
  get 'recommends/new'
  get 'recommends/destroy'
  get 'recommends/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  scope :geeksalon do
    resources :users, only: [:show]
    resources :posts, except: [:edit, :update]
  end

  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
