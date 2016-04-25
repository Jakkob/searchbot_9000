class HTTPProxy < ActiveRecord::Base

	def get_random
		HTTPProxy.order("RANDOM()").first.base_attributes
	end

	def self.base_attributes
		hash = self.attributes
		%w(id updated_at created_at).each { |x| hash.delete(x) }
		hash
	end
end