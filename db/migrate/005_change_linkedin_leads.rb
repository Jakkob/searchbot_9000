class ChangeLinkedinLeads < ActiveRecord::Migration
	def change
		rename_column :linkedin_leads, :valid, :approved
	end
end