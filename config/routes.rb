Ecoin::Application.routes.draw do
  root :to => 'home#index'
  resources :merchants do
  collection do
  post '/sendtxt/:bal', :action => 'sendtxt'

  end
end


get 'sendtxt' => 'merchants#index'
get '/login' => 'session#new'
post '/login' => 'session#create'
get '/logout' => 'session#destroy'

post 'sendtxt' => 'merchants#sendtxt'
post 'redeemtxt' => 'merchants#redeemtxt'

get '/redeem/:id' => 'merchants#redeem', :as => 'redeem'

get '/u/:sha1' => 'user#profile'

end



