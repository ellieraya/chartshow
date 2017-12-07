Rails.application.routes.draw do
  root 'graph#index'
  get 'graph/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
