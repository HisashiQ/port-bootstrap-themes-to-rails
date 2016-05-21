require "fileutils"



def move_css(rails_path)
	@scss_files = []
	Dir.foreach('.') do |f|
	 next if f.start_with?('.')
	 if File.directory?(f)
	    if f == "css" # Find the css directory
	     Dir.chdir(f) do # Enter css directory
	      puts 'Starting to move all minified css to public/assets/stylesheets'
	       Dir.foreach('.') do |f|
	        next if f.start_with?('.') or File.directory?(f)
	        if f.include?('.min.')
		        print ">>>   "
	          FileUtils.cp f, "#{rails_path}/vendor/assets/stylesheets/", verbose: :true # Copies minified css files into Vendor/assets/stylesheets
	        end
	       end
	      puts 'Renaming all .css to css.scss'
	      Dir.foreach('.') do |f|
		      next if f.start_with?('.') or File.directory?(f)
		      if !f.include?('.min.') && f.include?('.css') && !f.include?('scss')
			        print ">>>   "
							FileUtils.mv  f, "#{f}.scss", verbose: :true
		      end
		      if f.include?('.scss')
			      print ">>>   "
			      FileUtils.cp f, "#{rails_path}/app/assets/stylesheets/", verbose: :true # Copies  scss files into app/assets/stylesheets
		      end
	      end
	      Dir.foreach('.') do |f|
		      if !f.include?('.min')
						@scss_files << f
		      end
	      end
	      end
	    end
	 end
	end
	end

def move_js(rails_path)

	Dir.foreach('.') do |f|
	 next if f.start_with?('.')
	 if File.directory?(f)
	    if f == "js" # Find the js directory
	     Dir.chdir(f) do # Enter js directory
	      puts "Starting to move all minified js to public/assets/javascripts"
	       Dir.foreach('.') do |f|
	        next if f.start_with?('.') or File.directory?(f)
	        if f.include?('.min.')
		        print ">>>   "
	          FileUtils.cp f, "#{rails_path}/vendor/assets/javascripts/", verbose: :true # Copies minified js files into Vendor/assets/stylesheets
	        end
	       end
	      puts "Starting to move all js to app/assets/javascripts"
	      Dir.foreach('.') do |f|
		      next if f.start_with?('.') or File.directory?(f)
		      if f.include?('js') && !f.include?('min')
						print ">>>   "
			      FileUtils.cp f, "#{rails_path}/app/assets/javascripts/", verbose: :true # Copies js files into app/assets/stylesheets
		      end
	      end
	     end
	    end
	 end
	end
end

# def change_application_css(rails_path)
# 	File.delete("#{rails_path}/app/assets/stylesheets/application.css")
#
# 	@scss_files.each do |f|
# 		split_scss_file = f.split('.')
#
# 		write_to_scss_manifest = split_scss_file[0]
# 		File.open('application.css.scss', 'w') { |file| file.puts("@import #{write_to_scss_manifest};") }
# 	end
# end
puts "Hi! Where would you like me to port this theme to? Enter the rails_path"
a = gets.chomp
move_css(a)
move_js(a)
change_application_css(a)