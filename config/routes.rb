Picbase::Application.routes.draw do

#get "/pictures" => "Pictures#index"
#get("/pictures/:size/:color", :controller => 'Pictures',
#    :action => 'index')
#end

get "/pictures" => "Pictures#index"
get "/pictures/:url" => "Pictures#showpic"

end
