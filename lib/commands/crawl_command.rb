require "#{$ROOT_DIR}/lib/crawler"
require "#{$ROOT_DIR}/lib/cli_helpers/etl_cli_helpers"

ARGV.each { |x| x = x.chomp }

range = ARGV[0].is_range?

if range
	puts range
	SearchBot::Crawler.new(Person.where(:resume_year => range[0]..range[1])).crawl!
elsif ARGV[0] =~ /\d{4}/
	puts [ARGV[0].to_i, ARGV[1].to_i]
	if ARGV[1]
		SearchBot::Crawler.new(Person.where(:resume_year => ARGV[0]..ARGV[1])).crawl!
	else
		SearchBot::Crawler.new(Person.where(:resume_year => ARGV[0])).crawl!
	end
else
	puts "There was an error with your argument(s)!"
end