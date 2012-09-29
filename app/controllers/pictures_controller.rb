class PicturesController < ApplicationController

def index
	counter = 0
	@urln = []
	@fulln = []

	namesdoc = File.open("actorlist.txt","r").readlines
	namesdoc.each do |line|
		if counter%2 == 0
			@urln << line
		else @fulln << line
		end
		counter += 1
	end
end

def showpic
	@url = params[:url]
	@img = []
	picnames = File.open("public/imgbase/#{@url}.txt","r").count
	(1..picnames).each do |i|
		@img << "#{@url}#{i}.jpg"
	end
end

def form
	require 'open-uri'
	require 'pathname'
	require 'nokogiri'

	name = params[:name].to_s

	name = name.gsub("\n","")
	fulln = name.gsub("-"," ")
	fulln = fulln.gsub("_"," ")
	fulln = fulln.split(" ").each{|word| word.capitalize!}.join(" ")

	url = "http://rottentomatoes.com/celebrity/" + name

	doc = Nokogiri::HTML(open(url))
	afile = File.new("public/imgbase/#{name}.html","w+")
	afile.write(doc)
	afile.close

	url = "#{name}.html".gsub("\n","")

	 keepers = []
	 alts = []
	 text = File.new("public/imgbase/#{name}.txt","w")

	doc.search(">Full") do ||
		alts = img.attributes['alt'].to_s

	    if alts.include?("#{fulln}")
	    	if img['src'].include?("pro")
	            text.puts(img['src'])
	    	elsif
	    		thesplits = img['src'].split('_')
	    		thesplits[0] = "#{thesplits[0]}_ori.jpg"
	            text.puts(thesplits[0])
	    	end
		end
	end




	doc.search("//img").each do |img|
		alts = img.attributes['alt'].to_s

	    if alts.include?("#{fulln}")
	    	if img['src'].include?("pro")
	            text.puts(img['src'])
	    	elsif
	    		thesplits = img['src'].split('_')
	    		thesplits[0] = "#{thesplits[0]}_ori.jpg"
	            text.puts(thesplits[0])
	    	end
		end
	end

	text.close
	n = 0
	npath = Pathname.new("imgbase/#{name}/")
	text = File.open("public/imgbase/#{name}.txt","w+")
	#if File.directory? "public/#{npath}" == false
		Dir.mkdir("public/#{npath}",0777)
	#end

	text.each{|line|
		n += 1
		fname = "public/imgbase/#{name}/#{name}#{n}.jpg"
		open(fname, 'wb') do |file|
	  		file << open(line).read
		end
	}

	text.close
	redirect_to "http://localhost:3000/pictures"

	end

end

