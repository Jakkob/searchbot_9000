class CreateLinkedinLeads < ActiveRecord::Migration
	def change
		create_table :linkedin_leads, force: true do |t|
			t.string :title, null: false
			t.string :url, null: false
			t.integer :rank, null: false
			t.boolean :valid, null: false, default: true
			t.references :person

			t.timestamps
		end
	end
end