require 'support/number_helper'
class Restaurant
  include NumberHelper

  attr_accessor :name, :cuisine, :price, :rating

  @@filepath = nil

  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end


  def self.file_usable?
    return false unless @@filepath
    return false unless File.exist?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end

  def self.create_file
    File.open(@@filepath, 'w')
    file_usable?
  end

  def self.saved_restaurants
    restaurants = []
    if file_usable?
      file = File.open(@@filepath, 'r')
      file.each_line do |line|
        restaurants << Restaurant.new.import_line(line.chomp)
      end
      file.close
    end
      restaurants
  end

  #ADD Method
  def self.build_questions
    puts "\nAdding a restaurant\n\n".upcase
    args = {}
    puts "Restaurant Name: "
    args[:name] = gets.chomp.strip
    puts "Restaurant Type: "
    args[:cuisine] = gets.chomp.strip
    puts "Average Price: "
    args[:price] = gets.chomp.strip
    puts "1/10 rating: "
    args[:rating] = gets.chomp.strip
    self.new(args)
  end

  def initialize(args={})
    @name    = args[:name] || ""
    @cuisine = args[:cuisine] || ""
    @price   = args[:price] || ""
    @rating  = args[:rating] || ""
  end

  def import_line(line)
  line_array = line.split("\t")
  @name, @cuisine, @price, @rating = line_array
    self
  end

  def save
    return false unless Restaurant.file_usable?
    File.open(@@filepath, 'a') do |file|
      file.puts "#{[@name, @cuisine, @price, @rating].join("\t")}\n"
    end
     true
  end

  def formatted_price
    number_to_currency(@price)
  end
end