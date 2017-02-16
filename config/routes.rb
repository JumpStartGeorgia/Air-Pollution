Rails.application.routes.draw do
  
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    # post '/users', to: 'users#create'

    devise_for :users,
               # controllers: {
               #   confirmations: 'users/confirmations',
               #   omniauth: 'users/omniauth',
               #   passwords: 'users/passwords',
               #   registrations: 'users/registrations',
               #   sessions: 'users/sessions',
               #   unlocks: 'users/unlocks'
               # },
               path_names: {sign_in: 'login', sign_out: 'logout'},
               constraints: { format: :html }, 
               skip: :omniauth_callbacks

    match '/admin', :to => 'admin#index', :as => :admin, :via => :get
    namespace :admin do
      resources :users, constraints: { format: :html }
      resources :page_contents, constraints: { format: :html }
      resources :highlights, constraints: { format: :html }
    end

    get '/stories/:id', :to => 'root#story', :as => :story
    get '/stories', to: redirect('/')
    get '/pledges/:id', :to => 'root#pledge', :as => :pledge
    get '/pledges/:id/make_pledge', :to => 'root#make_pledge', :as => :make_pledge
    get '/pledges', to: redirect('/')
    get '/about' => 'root#about'

    root 'root#index'

    # handles /en/fake/path/whatever
    get '*path', to: redirect("/#{I18n.default_locale}")
  end

  # handles /
  get '', to: redirect("/#{I18n.default_locale}")

  # handles /not-a-locale/anything
  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")


end
