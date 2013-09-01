Ecoin::Application.routes.draw do
  root :to => 'merchants#index'

get '/login' => 'session#new'
post '/login' => 'session#create'
get '/logout' => 'session#destroy'

post 'sendtxt' => 'merchants#sendtxt'

end



