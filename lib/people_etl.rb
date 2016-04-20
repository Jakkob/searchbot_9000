require "#{$ROOT_DIR}/lib/models/encore_socket"
require "#{$ROOT_DIR}/lib/encore_queries"

module SearchBot

	class EncoreETL

		attr_reader :year_one, :year_two
		# attr_accessor :storage

		def initialize(year_one, year_two = nil)
			@year_one = validate_year(year_one)
			@year_two = year_two || validate_year(year_one) + 1
			# @storage = []
		end

		def run_etl_process!
			puts "Collecting the Encore records from #{@year_one} through #{@year_two}..."
			query = query_encore
			SearchBot::LOGGER.debug "Class of 'query' object: #{query.class}"
			SearchBot::LOGGER.debug "number of items in  'query' object: #{query.length}"
			SearchBot::LOGGER.debug "Class of 'query' object's first item: #{query[0].class}"
			result = dump_to_db(query)
			puts "Complete. #{result[:success]} of the total #{result[:success] + result[:fail]} items were successfully added to the database!"
		end

		private
		def query_encore
			query = SearchBot::EncoreQueries.find_people_for_etl(@year_one, @year_two)

			EncoreSocket.find_by_sql(query)
		end

		def dump_to_db(payload)
			stats = { :success => 0, :fail => 0}
			payload.each do |item|
				item_hash = item.attributes
				%w(dnp_status last_updated).each { |x| item_hash.delete(x) }
				new_person = Person.create(item_hash)
				if new_person.save
					stats[:success] += 1
					SearchBot::LOGGER.info "Record added from Encore: #{new_person.first_name} #{new_person.last_name}"
				else
					stats[:success] += 1
					SearchBot::LOGGER.error "There was an error!"
				end
			end
			stats
		end

		def validate_year(year)
			require 'date'
			year = year.to_i
			this_year = Date.today.year.to_i
			if year > 1900 && year <= this_year
				return year
			else
				this_year
			end
		end
	end
end