class HttpProxy < ActiveRecord::Base

	validates_uniqueness_of :host, :message => "Proxy server already exists!"

	def self.get_random
		self.order("RANDOM()").first
	end

	def safe_attributes
		hash = self.attributes
		%w(id updated_at created_at).each { |x| hash.delete(x) }
		hash
	end
end