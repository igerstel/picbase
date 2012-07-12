class PicturesController < ApplicationController

def index
#	@size = params["size"]
	n = 0
	@urln = []
	@fulln = []

	doc = File.open("actorlist.txt","r").readlines
	doc.each do |i|
		if n%2 == 0
			@urln << i
		else @fulln << i
		end
		n = n+1
	end
end

def showpic
	@url = params[:url]
	@img = []
	picn = File.open("public/imgbase/#{@url}.txt","r").count
	[1..picn].each do |i|
		@img << "#{@url}"+i.to_s+".jpg"
	end
end

end