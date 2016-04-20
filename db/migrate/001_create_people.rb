class CreatePeople < ActiveRecord::Migration
	def change
		create_table :people, force: true do |t|
			t.string :first_name, null: false
			t.string :last_name, null: false
			t.string :encore_guid, null: false
			t.string :city
			t.string :state
			t.integer :resume_year
			t.string :last_known_employer
			t.string :last_known_title
			t.integer :last_known_start_date
			t.string :resume_link

			t.timestamps
		end
	end
end