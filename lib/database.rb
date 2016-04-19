require 'activerecord'
require 'activerecord-sqlserver-adapter'
require 'tiny_tds'

# TODO configure this logger globally...
# ActiveRecord::Base.logger = Logger.new('../logs/debug.log')
db_config = YAML::load(IO.read('../config/database.yml'))

ActiveRecord::Base.establish_connection(db_config['main'])

class Socket < ActiveRecord::Base
	self.establish_connection(db_config['encore'])
end