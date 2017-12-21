Rails.application.routes.draw do
  #mount_devise_token_auth_for "User", at: "auth"
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      sessions:  'users/sessions'
  }
  root "welcome#index"

  resources :tasks, except: [:show] do
    resources :task_files, only: [:index, :new, :create, :show]
  end

  get "/tasks/:id/edit", to: "welcome#index"
  get "/tasks/new", to: "welcome#index"

  namespace :tasks do
    resource :task_end, only: [:create]
  end
end
