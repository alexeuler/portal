Portal::Application.routes.draw do

  root to: 'forum::boards#index'

  namespace :forum do
    resources :boards
    resources :board_groups
  end

end
