Picbase::Application.routes.draw do

get "/pictures" => "Pictures#index"
post "/pictures/form" => "Pictures#form"
get "/pictures/:url" => "Pictures#showpic"

end
