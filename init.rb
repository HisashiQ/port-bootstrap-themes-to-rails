require "fileutils"



def css(rails_path)

Dir.foreach('.') do |f|
 next if f.start_with?('.')
 if File.directory?(f)
    if f == "css" # Find the css directory
     Dir.chdir(f) do # Enter css directory
     	puts "Starting to move all minified css to public/assets/stylesheets"
     	 Dir.foreach('.') do |f|
     	 	next if f.start_with?('.') or File.directory?(f)
     	 	if f.include?('.min.')
     	 		FileUtils.cp f, "#{rails_path}/vendor/assets/stylesheets/" # Copies minified css files into Vendor/assets/stylesheets
     	 	end
     	 end
     	end
    end
   	end
 end
end

puts "Hi! Where would you like me to port this theme to? Enter the rails_path"
a = gets.chomp

css(a)
