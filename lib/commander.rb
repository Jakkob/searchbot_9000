module SearchBot

	class Commander

		attr_reader :argv

		HELP_MESSAGE = <<-EOT

Usage: searchbot COMMAND [ARGS]
The available SearchBot commands are:
  find_person    Attempts to find any record of a person. First & last name required.
 	         Ex: >$ searchbot find_person "Bob Bobberson"
  mine	         Attempts to find evidence of all the people from the year or year-range you include.
 	         Ex: >$ searchbot mine 1999
 	         Or:
 	         Ex: >$ searchbot mine 1999..2000		
  help           Shows this message!
Additional commands are in progress...\n
EOT

		COMMAND_WHITELIST = %W(find_person mine help test)

		def initialize(argv)
			@argv = argv
		end

		def run_command!(command)
			command = parse_command(command)

			if COMMAND_WHITELIST.include?(command)
				require "#{$ROOT_DIR}/lib/init" unless command == 'help' # The 'help' command should not load the init script. Don't load the DB if you don't have to!
				send(command)
			else
				puts "You attempted to use an unsupported command, please try again..."
			end
		end

		def help
			write_help_message
		end

		# TODO: Write this method once I have more application code
		def find_person
			write_placeholder_text
		end

		# TODO: Write this method once I have more application code
		def mine
			write_placeholder_text
		end

		def test
			require "#{$ROOT_DIR}/lib/test_script"
		end

		# TODO: Add command for generating a 'secrets.yml' file! That would be nice! ^~^
		private
		def parse_command(command)
      case command
      when '--help', '-h', '--h'
        'help'
      else
        command
      end
    end

    def write_help_message
      puts HELP_MESSAGE
    end

    def write_placeholder_text
    	print "In-progress...\nIncluded arguments: "
    	puts @argv.join("")
    end
	end
end