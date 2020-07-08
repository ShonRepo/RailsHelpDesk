Rails.application.routes.draw do


  get 'pages/start'
  namespace :operator do
    #resources :tickets, only: [:index, :show, :edit, :update, :new]
    resources :tickets, only: [:index, :show, :edit, :update, :new] do
      resources :tinymce_images, only: :create, owner: 'ticket'


    end
    resources :answers, only: [:create]
    #get '/operators/edit'
    #put '/operators/update'
    resources :operators, only: [:edit,:update]
    resources :tickets do
      resources :answers, only: [:index, :destroy, :create, :new]
    end

    root to: "tickets#index"
    get 'tickets/:id/create_stage', to: 'tickets#create_stage' , as: 'stage'
    get 'tickets/(:id)/take', to: 'tickets#take' , as: 'take'
    get 'indexthis', to: 'tickets#indexthis' , as: 'indexthis'
  end

  scope :operator do
    devise_for :operators, controllers: { sessions: 'operator/operators/sessions', passwords: 'operator/operators/passwords' }
  end

  scope :admin do
    devise_for :admins, controllers: { sessions: 'admin/admins/sessions' }
  end

  namespace :admin do
    root to: "tickets#index"

    resources :types,  except: :show

    resources :admins,  except: :show

    resources :statuses,  except: :show

    resources :operators,  except: :show

    resources :tickets, only: [] do
      resources :tinymce_images, only: :create, owner: 'ticket'
    end
    get 'tickets/:id/create_stage', to: 'tickets#create_stage' , as: 'stage'

    resources :tickets do
      resources :answers, only: [:index, :destroy, :create, :new]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
