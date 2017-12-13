Rails.application.routes.draw do
  root "welcome#index"
  devise_for :users, controllers: {
    sessions: "users/sessions",
  }

  resources :tasks, except: [:show] do
    resources :task_files, only: [:index, :new, :create, :show]
  end

  get '/tasks/:id/edit', to: 'welcome#index'
  get '/tasks/new', to: 'welcome#index'

  namespace :tasks do
    resource :task_end, only: [:create]
  end
end
