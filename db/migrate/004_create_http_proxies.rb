class CreateHTTPProxies < ActiveRecord::Migration
	def change
		create_table :http_proxies, force: true do |t|
			t.string :host, null: false
			t.string :port, null: false
			t.string :protocol, null: false
			t.string :user
			t.string :password

			t.timestamps
		end
	end
end