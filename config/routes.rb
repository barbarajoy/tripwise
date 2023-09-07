Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :trips, only: %i[index show]
  namespace :my do
    resources :trips, only: %i[new create update show] do
      resources :messages, only: %i[create]
    end
    patch 'trip_custom_validate/:id', to: 'trips#custom_validate', as: :trip_custom_validate
    get 'trip_download_pdf/:id', to: 'trips#download_pdf', as: :trip_download_pdf

  end
  namespace :planner do
    resources :trips, only: %i[index show new create edit update destroy]
  end
end


# root to: "cats#index"
# resources :cats, only: %i[index show new create] do
#   resources :reservations, only: %i[new]
#   resources :reservations, only: %i[create], path: ''
# end
# namespace :admin do
#   resources :cats, only: %i[index show]
# end
# devise_for :users, controllers: {
#   sessions: 'users/sessions'
# }
