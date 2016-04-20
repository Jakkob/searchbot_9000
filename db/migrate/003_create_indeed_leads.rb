class CreateIndeedLeads < ActiveRecord::Migration
	def change
		create_table :indeed_leads, force: true do |t|
			t.string :title, null: false
			t.string :url, null: false
			t.integer :rank, null: false
			t.boolean :valid, null: false, default: true
			t.string :city
			t.string :state
			t.string :most_recent_employer
			t.string :most_recent_title
			t.date :last_updated

			t.references :person

			t.timestamps
		end
	end
end