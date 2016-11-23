# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get '/spectator', :to => 'spectator#index'
post '/spectator/change_user', :to => 'spectator#change_user'
get '/spectator/user_list', :to => 'spectator#user_list'