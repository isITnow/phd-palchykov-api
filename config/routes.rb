Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :publication_periods, only: %i[index show] do
        resources :publications, except: %i[index show]
      end

      resources :colleagues, except: %i[show]
      resources :news
    end
  end

  # root "articles#index"
end
