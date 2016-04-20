require 'active_record'
require 'pg'

require 'erb'

# Instantiate a new logger for the DB logs
ActiveRecord::Base.logger = Logger.new("#{$ROOT_DIR}/logs/db.log")
ActiveRecord::Base.logger.formatter = Logger::Formatter.new

# Parse the 'database.yml' file, taking care to eval the ERB contained within
module SearchBot
	template = ERB.new File.read("#{$ROOT_DIR}/config/database.yml")
	SearchBot::DB_CONFIG = YAML.load template.result binding
end

# Load the main database globally
ActiveRecord::Base.establish_connection(SearchBot::DB_CONFIG['main'])

# Load all the postgres ActiveRecord models
require "#{$ROOT_DIR}/lib/models"