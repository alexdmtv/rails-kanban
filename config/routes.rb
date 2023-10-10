Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :boards do
    resources :lists, only: [:reorder] do
      member do
        patch :reorder
      end
    end
    member do
      get :confirm_destroy
    end
  end

  resources :tasks, except: [:index] do
    resources :subtasks, only: [:reorder] do
      member do
        patch :reorder
      end
    end
    member do
      patch :reorder
    end
  end

  root 'boards#index'
end
