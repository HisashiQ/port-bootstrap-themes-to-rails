require 'fileutils'

class Manifest_file

  def change_application_css(rails_path)
  	File.delete("#{rails_path}/app/assets/stylesheets/application.css")

  	@scss_files.each do |f|
  		split_scss_file = f.split('.')

  		write_to_scss_manifest = split_scss_file[0]
  		File.open('application.css.scss', 'w') do |file|
        file.puts("@import #{write_to_scss_manifest};")
      end

    end
  end
end