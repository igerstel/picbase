require 'nokogiri'
require 'open-uri'

name = "public/imgbase/bill_murray"
url = name + ".html"
doc = Nokogiri::HTML(open(url))

#text = File.new("#{name}.txt","w")

    start = doc.search(">Full")
    stop = doc.search(" Bio</a></div>")

fulln = doc[/#{start}(.*?)#{stop}/m, 1]
puts fulln
text.close