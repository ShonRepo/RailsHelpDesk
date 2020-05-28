Rails.application.routes.draw do

  
  scope :admin do
    devise_for :admins, controllers: {sessions: 'admin/admins/sessions'}
  end

  namespace :admin do
    root to: "main#index"
    get 'main/index'
    resources :types,  except: :show
    resources :admins,  except: :show

    resources :tickets do
      resources :answers, only: [:index, :destroy, :create, :new]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end