Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :trips, only: %i[index show]
  namespace :my do
    resources :trips, only: %i[create show] do
      resources :messages, only: %i[create]
    end
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
