require 'logger'
require 'yaml'
require 'hashie'

# TODO: Add custom Exception to inform user that they do not have a 'secrets.yml' file!

# Load the 'secrets.yml' file into memory
module SearchBot
	SearchBot::SECRETS = Hashie::Mash.load("#{$ROOT_DIR}/config/secrets.yml")
end

# Load the database(s)
require "#{$ROOT_DIR}/lib/database"

# Create a new logger and apply better formatting
SearchBot::LOGGER = Logger.new("#{$ROOT_DIR}/logs/main.log")
SearchBot::LOGGER.formatter = Logger::Formatter.new

# def print_thing(res)
# 	puts res.index
# 	puts res.title
# 	puts res.uri
# 	puts res.content
# 	puts res.cache_uri
# end

# ENV["http_proxy"] = "http://216.231.209.120:8080"

# cse_id = "011658049436509675749:mpshzk7cxw8"

# first_name = "mark"
# last_name = "prisby"

# results = Google::Search::Web.new(:query => %(#{first_name} #{last_name} (mortgage OR bank OR "real estate")), :cx => cse_id)

# # puts results.inspect

# important_results = results.select do |x|
# 	stuff = x.title.split(" ")
# 	stuff.each { |y| y.downcase! }
	
# 	stuff.include?(first_name) && stuff.include?(last_name)
# end

# important_results.each { |z| print_thing z }