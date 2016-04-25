require "#{$ROOT_DIR}/lib/people_etl"
require "#{$ROOT_DIR}/lib/cli_helpers/etl_cli_helpers"

ARGV.each { |x| x = x.chomp }

range = ARGV[0].is_range?

if range
	puts range
	SearchBot::EncoreETL.new(range[0], range[1]).run_etl_process!
elsif ARGV[0] =~ /\d{4}/
	puts [ARGV[0].to_i, ARGV[1].to_i]
	SearchBot::EncoreETL.new(ARGV[0].to_i, ARGV[1].to_i).run_etl_process!
else
	puts "There was an error with your argument(s)!"
end