APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'css_file'
require 'javascript_file'
require 'manifest_file'

puts "Hi! Where would you like me to port this theme to? Enter the rails_path"
rails_path = gets.chomp
css = CssFile.new
css.move_css(rails_path)
js = JavascriptFile.new
js.move_js(rails_path)
manifest = ManifestFile.new
manifest.change_application_css(rails_path)