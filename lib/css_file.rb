require 'fileutils'

class CssFile

  def move_css(rails_path)
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
            end
            puts "Starting to move all scss to app/assets/stylesheets"
            Dir.foreach('.') do |f|
              next if f.start_with?('.') or File.directory?(f)
              if f.include?('scss')
                print ">>>   "
                FileUtils.cp f, "#{rails_path}/app/assets/stylesheets", verbose: :true # Copies scss files into app/assets/stylesheets
              end
            end
          end
        end
      end
    end
  end

end