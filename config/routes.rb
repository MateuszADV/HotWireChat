Rails.application.routes.draw do
  resources :rooms do
    resource :messages
  end

  resource :messages

  get 'messages_controller/destroy/:id', to: 'messages#destroy', as: 'destroy'
  root to: 'rooms#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
