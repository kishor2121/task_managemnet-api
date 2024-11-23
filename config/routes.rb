Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :workspaces, only: [:create] do
    post 'add_team_member', on: :member 
  end

  resources :tasks

  resources :categories do
    get 'tasks', on: :member
  end

end
