Rails.application.routes.draw do
  get("/", { :controller => "misc", :action => "homepage" })

  get("/directors/youngest", { :controller => "directors", :action => "max_dob" })
  get("/directors/eldest", { :controller => "directors", :action => "min_dob" })

  get("/directors", { :controller => "directors", :action => "index" })
  get("/directors/:path_id", { :controller => "directors", :action => "show" })
  post("/insert_director", { :controller => "directors", :action => "create" })
  get "/delete_director/:id", to: "directors#destroy"
  post("/update_director/:id", { :controller => "directors", :action => "update" })


  get("/movies", { :controller => "movies", :action => "index" })
  get("/movies/:path_id", { :controller => "movies", :action => "show" })
  post("/insert_movie_record", { :controller => "movies", :action => "create" })
  post("/update_movie/:id", { :controller => "movies", :action => "update" })
  get("/delete_movie/:id", { :controller => "movies", :action => "destroy" })
  
  get("/actors", { :controller => "actors", :action => "index" })
  get("/actors/:path_id", { :controller => "actors", :action => "show" })
  post("/insert_actor", { :controller => "actors", :action => "create" })
  post("/update_actor/:id", { :controller => "actors", :action => "update" })
  get("/delete_actor/:id", { :controller => "actors", :action => "destroy" })
end
