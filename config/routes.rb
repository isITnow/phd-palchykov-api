Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :publication_periods, only: %i[index create destroy] do
        resources :publications, except: %i[show]
      end

      resources :colleagues, except: %i[show]
      resources :news
      resources :researches, only: %i[index create destroy] do
        resources :illustrations, only: %i[create]
      end
    end
  end

  # root "articles#index"
end
