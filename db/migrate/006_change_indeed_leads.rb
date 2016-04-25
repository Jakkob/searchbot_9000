class ChangeIndeedLeads < ActiveRecord::Migration
	def change
		rename_column :indeed_leads, :valid, :approved
	end
end