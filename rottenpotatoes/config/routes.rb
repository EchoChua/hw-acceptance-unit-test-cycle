Rottenpotatoes::Application.routes.draw do
  resources :movies
  root :to => redirect('/movies')
  # map '/' to be a redirect to '/movies'
  get '/movies/similar_director/:id', :to => 'movies#similar_director', :as => 'similar_director'

end
