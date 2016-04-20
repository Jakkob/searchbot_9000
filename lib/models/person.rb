class Person < ActiveRecord::Base
	has_many :linkedin_leads, :dependent => :destroy
	has_many :indeed_leads, :dependent => :destroy

end