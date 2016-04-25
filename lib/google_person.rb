require 'google-search'
require_relative './proxy_override_for_google_search'

module SearchBot

	class GooglePerson

		attr_reader :last_name, :company, :city, :state, :use_random_proxy
		attr_accessor :first_name, :results

		def initialize(hash, options = {})
			@first_name = hash["first_name"]
			@last_name = hash["last_name"]
			@company = hash["company"] || nil
			@city = hash["city"] || nil
			@state = hash["state"] || nil
			@use_random_proxy = options[:use_random_proxy] || false
		end

		def get_raw
			# results = Google::Search::Web.new(:query => %(#{@first_name} #{@last_name} (mortgage OR bank OR "real estate")), :cx => SearchBot::SECRETS.google_search.cse_id)
			search_results = Google::Search::Web.new do |search_results|
		    search_results.query = %(#{@first_name} #{@last_name} (mortgage OR bank OR "real estate"))
		    search_results.options[:cx] = SearchBot::SECRETS.google_search.cse_id
		    search_results.size = :large
		    search_results.proxy = HTTPProxy.get_random if @use_random_proxy
		    search_results.each_response { print '.'; $stdout.flush }
		  end
		  @results = search_results.select { |item| title_is_valid(item) }
		end

		private
		def title_is_valid?(result)
			result.title =~ /#{@first_name}/i && result.title =~ /#{@last_name}/i
		end

	end

end