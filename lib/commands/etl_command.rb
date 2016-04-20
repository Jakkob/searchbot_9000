require "#{$ROOT_DIR}/lib/people_etl"
patt = /\d{4}/
args = ARGV[0].split("..") if ARGV[0].is_a? String
if args && args.length == 2
	if args[0].chomp.match(patt) && args[1].chomp.match(patt)
		SearchBot::EncoreETL.new(args[0].to_i, args[1].to_i).run_etl_process!
	elsif args[0].chomp.match(patt)
		SearchBot::EncoreETL.new(args[0].to_i).run_etl_process!
	end
elsif ARGV[0].to_s.chomp.match(patt) && ARGV[1].to_s.chomp.match(patt)
	SearchBot::EncoreETL.new(ARGV[0].to_i, ARGV[1].to_i).run_etl_process!
elsif ARGV[0].to_s.chomp.match(patt)
	SearchBot::EncoreETL.new(ARGV[0].to_i).run_etl_process!
else
	puts "There was an error with your argument(s)!"
end