Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users
      
      resources :colleagues, except: %i[new edit show]
      resources :news, except: %i[new edit show]

      resources :posts, except: %i[new edit]

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
