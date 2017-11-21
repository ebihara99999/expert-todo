Rails.application.routes.draw do
  root "welcome#index"
  devise_for :users, controllers: {
    sessions: "users/sessions",
  }

  resources :tasks, except: [:show] do
    resources :task_files, only: [:index, :create]
  end
  resource :task_state, only: [:update]
end
