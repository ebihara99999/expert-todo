Rails.application.routes.draw do
  root "welcome#index"
  get 'login' => 'user_sessions#new', :as => :login
  resources :user_sessions

  namespace :api do
    namespace :v1 do
      namespace :users do
        resources :sessions, only: [:new, :create], defaults: { format: :json }
      end

      resources :tasks, except: [:show], defaults: { format: :json } do
        resources :task_files, only: [:index, :new, :create, :show]
      end

      namespace :tasks do
        resource :task_end, only: [:create]
      end
    end
  end
end
