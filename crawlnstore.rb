require 'open-uri'
require 'pathname'
require 'nokogiri'

puts "Enter a name URL: "
name = gets

name = name.gsub("\n","")
fulln = name.gsub("-"," ")
fulln = fulln.gsub("_"," ")
fulln = fulln.split(" ").each{|word| word.capitalize!}.join(" ")

url = "http://rottentomatoes.com/celebrity/" + name

doc = Nokogiri::HTML(open(url))
afile = File.new("imgbase/#{name}.html","w")
afile.write(doc)
afile.close

url = "#{name}.html".gsub("\n","")

 keepers = []
 alts = []
 text = File.new("imgbase/#{name}.txt","w")

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
text = File.open("imgbase/#{name}.txt","r")
Dir.mkdir("#{npath}",0777)

text.each{|line|
	n += 1
	fname = "imgbase/#{name}/#{name}#{n}.jpg"
	open(fname, 'wb') do |file|
  		file << open(line).read
	end
}

text.close

puts npath




