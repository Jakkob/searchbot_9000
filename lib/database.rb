require 'active_record'
require 'activerecord-sqlserver-adapter'
require 'tiny_tds'

require 'erb'

ActiveRecord::Base.logger = Logger.new("#{$ROOT_DIR}/logs/db.log")
ActiveRecord::Base.logger.formatter = Logger::Formatter.new

template = ERB.new File.read("#{$ROOT_DIR}/config/database.yml")
$db_config = YAML.load template.result binding

ActiveRecord::Base.establish_connection($db_config['main'])

class EncoreSocket < ActiveRecord::Base
	self.establish_connection($db_config['encore'])
end

require "#{$ROOT_DIR}/lib/models"