# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /ru|en/ do
    get 'tickets/index'
    get 'tickets/new'
    get 'tickets/:id/show', to: 'tickets#show', as: 'tickets_show'
    get 'tickets/search', to: 'tickets#search', as: 'search'
    get 'tickets/:id/create_stage', to: 'tickets#create_stage', as: 'stage'
    get 'tickets/edit'
    get 'tickets/create'
    get 'tickets/update'
    get 'tickets/delete'
    root to: 'pages#start'
    resources :faqs, only: %i[show]

    resources :answers, only: %i[create]
    resources :tickets do
      resources :answers, only: %I[index destroy create new]
    end

    resources :tickets do
      resources :tinymce_images, only: :create, owner: 'ticket'
    end
    namespace :operator do
      resources :tickets, only: %i[index show edit update new] do
        resources :tinymce_images, only: :create, owner: 'ticket'
      end

      resources :answers, only: %i[create]
      resources :operators, only: %i[edit update]
      resources :tickets do
        resources :answers, only: %I[index destroy create new]
      end

      root to: 'tickets#index'
      get 'tickets/:id/create_stage', to: 'tickets#create_stage', as: 'stage'
      get 'tickets/(:id)/take', to: 'tickets#take', as: 'take'
      get 'indexthis', to: 'tickets#indexthis', as: 'indexthis'
    end

    scope :operator do
      devise_for :operators, controllers: { sessions: 'operator/operators/sessions',
                                            passwords: 'operator/operators/passwords' }
    end

    scope :admin do
      devise_for :admins, controllers: { sessions: 'admin/admins/sessions' }
    end

    namespace :admin do
      root to: 'tickets#index'
      resources :types, except: :show
      resources :admins, except: :show
      resources :statuses, except: :show
      resources :confirmeds, except: :show
      resources :faqs do
        resources :tinymce_images, only: :create, owner: 'faq'
      end
      put 'confirmeds/:id/switch', to: 'confirmeds#switch', as: 'confirmeds_switch'
      resources :operators, except: :show
      resources :tickets, only: [] do
        resources :tinymce_images, only: :create, owner: 'ticket'
      end
      get 'tickets/:id/create_stage', to: 'tickets#create_stage', as: 'stage'
      resources :tickets do
        resources :answers, only: %i[index destroy create new]
      end
    end
  end
end
