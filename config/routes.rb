JsTesting::Application.routes.draw do
  post 'contact/create', controller: 'contact', action: 'create'
  root 'index#index'
end
