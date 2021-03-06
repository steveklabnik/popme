require "json"

module Popme
  class Storage
    JSON_FILE = "#{ENV['HOME']}/.popme"

    def initialize
      @list = {}
      @bootstraped = false
      bootstrap
      populate
    end

    attr_accessor :list

    def bootstrap
      return if File.exists?(JSON_FILE)
      @bootstraped = true
      @list["google"] = "http://google.com"
      save
    end

    def populate
      unless @bootstraped
        storage = JSON.parse File.read(JSON_FILE) 
        storage.each do |key, value|
          @list[key] = value
        end
      end
    end

    def save
      file = File.open(JSON_FILE, 'w') { |f| f.write to_file }
    end

    def to_file
      @list.to_json
    end

    def find_site(key)
      @list[key]
    end

    def list
      @list
    end

    def print_list
      @list.each do |key, value|
        puts "#{key} => #{value}"
      end
    end

    def add_site(key, value)
      @list[key] = value
      save
      puts "#{key} => #{value} saved to list"
    end
  end
end