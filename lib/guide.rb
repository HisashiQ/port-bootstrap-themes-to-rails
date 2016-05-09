require 'restaurant'
require 'support/string_extend'
class Guide

  class Config
    @@actions = %w(list find add quit x exit)
    def self.actions; @@actions; end
  end

  def initialize(path=nil)
    Restaurant.filepath = path
    if Restaurant.file_usable?
      puts "Found restaurant file."
    elsif Restaurant.create_file
      puts "Created restaurant file."
    else
      puts "Exiting.\n\n"
      exit!
    end
  end

  def launch!
    introduction
    result = nil
    until result == :quit do
      action, args = get_action
      result = do_action(action, args)
    end
    conclusion
  end

  def get_action
    action = nil
    until Guide::Config.actions.include?(action)
      puts "Available Actions: " + Guide::Config.actions.join(", ") if action
    print "> "
    user_response = gets.chomp
    args = user_response.downcase.strip.split(' ')
    action = args.shift

      end

    [action, args]
  end

  def do_action(action, args=[])
    #list, find, add or quit
    keyword = args.shift
    case action
      when 'list'
        list
      when 'find'
      find(keyword)
      when 'add'
        add
      when 'quit'
        :quit
      when 'exit'
        :quit
      when 'x'
        :quit
      else
        puts "\nI dont understand what you'd like me to do...\n"
    end
  end

  def add
    output_action_header("Adding Restaurant")
    restaurant = Restaurant.build_questions
    if restaurant.save
      puts "\n Restaurant Added!\n"
    else
      puts "\nSave Error: Restaurant not added\n"
    end
  end

  def list
    output_action_header("Listing restaurants")
    restaurants = Restaurant.saved_restaurants
    output_restaurant_table(restaurants)
  end

  def find(keyword="")
  output_action_header("Find a Restaurant")
    if keyword
      restaurants = Restaurant.saved_restaurants
      found = restaurants.select do |rest|
        rest.name.downcase.include?(keyword.downcase) ||
        rest.cuisine.downcase.include?(keyword.downcase) ||
        rest.price.to_i <= keyword.to_i
      end
      output_restaurant_table(found)
    else
      puts "Enter keyword to search."
      puts "For example, 'Find Mexican' or 'find chinese'."
    end
  end

  def introduction
    puts "\n\n<<< Welcome to the Food Finder >>>\n\n"
    puts "This is an interactive guide to help you find the food you crave.\n\n"
  end

  def conclusion
    puts "\n<<< See You Another Time and Good Eating! >>> \n\n\n"
  end

  private

  def output_action_header(text)
    puts "\n#{text.upcase.center(120)}\n\n"
  end

  def output_restaurant_table(restaurants=[])
    print " " + "Name".ljust(40)
    print " " + "Cuisine".ljust(30)
    print " " + "Price".ljust(20)
    print " " + "Rating".rjust(6) + "\n"
    puts "-" * 120
    restaurants.each do |r|
      line = " " << r.name.titleize.ljust(40)
      line << " " + r.cuisine.titleize.ljust(30)
      line << " " + r.formatted_price.ljust(20)
      line << " " + r.rating.rjust(6) + "/10"
      puts line
    end
    puts "No listing found" if restaurants.empty?
    puts "_" * 120
  end


    end