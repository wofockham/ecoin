Ecoin::Application.routes.draw do
  root :to => 'home#index'
  resources :merchants


get '/merchants/chart/:phone' => 'merchants#chart'
get '/merchants/chart/sum/:phone' => 'merchants#sum'
get 'sendtxt' => 'merchants#index'
get '/login' => 'session#new'
post '/login' => 'session#create'
get '/logout' => 'session#destroy'

post 'sendtxt' => 'merchants#sendtxt'
post 'redeemtxt' => 'merchants#redeemtxt'

get '/redeem/:id' => 'merchants#redeem', :as => 'redeem'

end



