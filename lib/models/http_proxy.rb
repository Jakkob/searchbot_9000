class HttpProxy < ActiveRecord::Base

	def self.get_random
		self.order("RANDOM()").first.base_attributes
	end

	def self.safe_attributes
		hash = self.attributes
		%w(id updated_at created_at).each { |x| hash.delete(x) }
		hash
	end
end