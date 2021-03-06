require "#{$ROOT_DIR}/lib/google_person"
# TODO: require "#{$ROOT_DIR}/lib/indeed_person"

module SearchBot

	class Crawler

		attr_accessor :people

		def initialize(people)
			@people = people
		end

		def crawl!(use_proxy = false)
			find_linkedin_leads(use_proxy)
			# TODO: Add Indeed.com to this...
		end
		
		##
		# Threaded querying of google enabled...
		#
		def find_linkedin_leads(use_proxy = false)
			SearchBot::LOGGER.info "Beginning threaded Google search on #{@people.length} people..."
			puts "Beginning threaded Google search on #{@people.length} people..."

			work_queue = Queue.new

			[*@people].each { |x| work_queue << x }

			workers = (0...4).map do
				Thread.new do
					begin
						
						while item = work_queue.pop(true)
							if use_proxy
								search = SearchBot::GooglePerson.new(item.safe_attributes, { :use_random_proxy => true })
							else
								search = SearchBot::GooglePerson.new(item.safe_attributes)
							end
							search.get_results
							search.results.each { |result| item.linkedin_leads.create!(result.get_simple_hash) }
						end

					rescue ThreadError
					end
				end
			end
			workers.map(&:join)

		end
	end
end
