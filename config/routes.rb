Rails.application.routes.draw do
  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    post '/users', to: 'users#create'

    devise_for :users,
               controllers: {
                 confirmations: 'users/confirmations',
                 omniauth: 'users/omniauth',
                 passwords: 'users/passwords',
                 registrations: 'users/registrations',
                 sessions: 'users/sessions',
                 unlocks: 'users/unlocks'
               },
               path_names: {sign_in: 'login', sign_out: 'logout'},
               constraints: { format: :html }

    match '/admin', :to => 'admin#index', :as => :admin, :via => :get
    namespace :admin do
      resources :users, constraints: { format: :html }
      resources :page_contents, constraints: { format: :html }
    end

    get '/stories/:id', :to => 'root#story', :as => :story
    get '/stories', to: redirect('/')
    get '/pledges/:id', :to => 'root#pledge', :as => :pledge
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
