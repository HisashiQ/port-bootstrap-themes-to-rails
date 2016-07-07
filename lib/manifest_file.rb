require 'fileutils'

class ManifestFile

  def initialize
    @scss_files = []
    Dir.foreach('.') do |f|
      next if f.start_with?('.')
      if File.directory?(f)
        if f == "css" # Find the css directory
          Dir.chdir(f) do # Enter css directory
            puts 'Building manifest file'
            Dir.foreach('.') do |f|
              next if f.include?('.min') or f.start_with?('.')
                @scss_files << f
              end
            end
          end
        end
      end
    end

  def change_application_css(rails_path)
    a = []
    @scss_files.each do |f|
      a << f.split('.')
    end

    a.each do |w|
      file_name = w.first
      File.open('application.css.scss', 'a+') do |file|
        file.puts("@import #{file_name};")
      end
    end
  end
end