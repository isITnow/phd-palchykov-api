Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, class_name: 'Api::V1::User', controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registrations',
      }
      
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
