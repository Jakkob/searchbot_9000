class Person < ActiveRecord::Base
	has_many :linkedin_leads, :dependent => :destroy
	has_many :indeed_leads, :dependent => :destroy

	def safe_attributes
		hash = self.attributes
		%w(id updated_at created_at).each { |x| hash.delete(x) }
		hash
	end
end