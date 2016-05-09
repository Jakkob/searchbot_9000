require 'logger'
require 'yaml'
require 'hashie'

# TODO: Add custom Exception to inform user that they do not have a 'secrets.yml' file!
# TODO: Add a CLI command for generating a 'secrets.yml' file! :D

# Load the 'secrets.yml' file into memory
module SearchBot
	SearchBot::SECRETS = Hashie::Mash.load("#{$ROOT_DIR}/config/secrets.yml")
end

# Load the database(s)
require "#{$ROOT_DIR}/lib/database"

# Create a new logger and apply better formatting
SearchBot::LOGGER = Logger.new("#{$ROOT_DIR}/logs/main.log")
SearchBot::LOGGER.formatter = Logger::Formatter.new