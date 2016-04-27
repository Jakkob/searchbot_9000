require 'csv'

HELP_COMMANDS = %w(-h --h -help --help help)

ALLOWED_KEYS = allowed_keys = [:host, :protocol, :port, :user, :password]

result_hash = {
	new: 0,
	duplicates: 0,
	invalid: 0
}

HELP_MESSAGE = <<-MSG

SearchBot help -> the 'load_proxies' command:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The 'load_proxies' command takes a CSV file as input and
loads the included proxy data into the app database.
An example of the accepted columns is provided below.
Required Columns: "host", "port", and "protocol"
________________________________________________________________
#{'"protocol"'.center(12)}|#{'"host"'.center(12)}|#{'"port"'.center(12)}|#{'"user"'.center(12)}|#{'"password"'.center(12)}
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
MSG

if HELP_COMMANDS.include?(ARGV[0]) || ARGV[0].nil? || ARGV[0].lstrip.empty?
	puts HELP_MESSAGE
else
	input = ARGF.file
	if File.exists?(input) && File.readable?(input)

		csv = CSV.new(input, headers: true, header_converters: :symbol).read
		if csv.headers.include?(:protocol) && csv.headers.include?(:port) && csv.headers.include?(:host)
			csv.each do |row|
				properties = row.to_hash
				properties.each_key { |k| properties.delete(k) unless ALLOWED_KEYS.include?(k.to_sym) }
				proxy = HttpProxy.create(properties)

				begin
					proxy.save!
				rescue ActiveRecord::RecordInvalid => invalid

					if invalid.record.errors.messages[:host].include?("Proxy server already exists!")
						puts "'#{invalid.record.protocol}' proxy #{invalid.record.host}:#{invalid.record.port} is a duplicate!"
						result_hash[:duplicates] +=1
					else
						puts "'#{row[:protocol]}' proxy #{row[:host]}:#{row[:port]} is INVALID!!"
						result_hash[:invalid] +=1
					end
				else
					if proxy
						puts "'#{proxy.protocol}' proxy #{proxy.host}:#{proxy.port} has been added!"
						result_hash[:new] +=1
					end
				end
			end
		end
	end
	puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	puts "Of the #{csv.length} items, #{result_hash[:new]} were added, #{result_hash[:duplicates]} were duplicates, and #{result_hash[:invalid]} were invalid."

end