require 'activerecord-sqlserver-adapter'
require 'tiny_tds'

# Load the Encore database ONLY into the following model. All Encore queries will be raw anyways
class EncoreSocket < ActiveRecord::Base
	self.establish_connection(SearchBot::DB_CONFIG['encore'])
end