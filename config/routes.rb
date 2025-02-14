# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#welcome'

  devise_for :users, path: '', path_names: {
                                 sign_in: 'login',
                                 sign_out: 'logout',
                                 registration: 'signup'
                               },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }

  resources :colleagues, except: %i[new edit]
  resources :news, except: %i[new edit]
  resources :photo_albums, except: %i[new edit]

  resources :posts, except: %i[new edit] do
    resources :comments, only: %i[create destroy]
  end

  resources :publication_periods, only: %i[index create destroy] do
    resources :publications, except: %i[new edit]
  end

  resources :researches, except: %i[new edit] do
    resources :illustrations, only: %i[create update delete]
  end

  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment'
end
