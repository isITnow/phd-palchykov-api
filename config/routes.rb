Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      devise_for :users, path: '', path_names: {
              sign_in: 'login',
              sign_out: 'logout',
              registration: 'signup'
            },
            controllers: {
              sessions: 'api/v1/users/sessions',
              registrations: 'api/v1/users/registrations'
            }
    end
  end

  namespace :api do
    namespace :v1 do
  
      resources :colleagues, except: %i[new edit show]
      resources :news, except: %i[new edit show]

      resources :posts, except: %i[new edit] do
        resources :comments, only: %i[create destroy]
      end

      resources :publication_periods, only: %i[index create destroy] do
        resources :publications, except: %i[new edit show]
      end

      resources :researches, only: %i[index create destroy] do
        resources :illustrations, only: %i[create]
      end
    end

  end

  # root "articles#index"
end
