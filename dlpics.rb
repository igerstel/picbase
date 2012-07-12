require 'open-uri'
require 'pathname'

require 'sqlite3'

n = 0
name = "bill_murray"
#name = "brie_larson"
text = File.open("imgbase/#{name}.txt","r")
npath = Pathname.new("imgbase/#{name}/")

puts npath

#Dir.mkdir(npath,0755)
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



begin
    
    fin = File.open "woman.jpg" , "rb"
    img = fin.read
    
rescue SystemCallError => e      
    puts e
ensure
    fin.close if fin 
end

begin
    
    db = SQLite3::Database.open 'images.db'
    blob = SQLite3::Blob.new img
    db.execute "INSERT INTO Images VALUES(1, ?)", blob
    
rescue SQLite3::Exception => e 
    
    puts "Exception occured"
    puts e
    
ensure
    db.close if db
end