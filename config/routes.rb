Rails.application.routes.draw do
  # Customers
  get '/customers', to: 'customer#show'
  post '/customers', to: 'customer#create'
  put '/customers/order', to: 'customer#order'
end
