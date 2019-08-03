Rails.application.routes.draw do
  # Customers
  get '/customers/:id', to: 'customer#show'
  get '/customers/:email', to: 'customer#show'
  post '/customers', to: 'customer#create'
  put '/customers/order', to: 'customer#order'
end
