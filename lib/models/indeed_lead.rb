class IndeedLead < ActiveRecord::Base
	belongs_to :person

	validates :url, :uniqueness => true
end