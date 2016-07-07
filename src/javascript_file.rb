require 'fileutils'


class Javascript_file

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

end