Rails.application.routes.draw do
  scope :admin do
    devise_for :admins, controllers: {sessions: 'admin/admins/sessions'}
  end

  namespace :admin do
    root to: "main#index"
    get 'main/index'
    resources :tickets, except: :show
    resources :types,  except: :show
    resources :admins,  except: :show
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
