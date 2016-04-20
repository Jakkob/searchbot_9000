# Thanks to the Rails developers for this nice CLI implementation example!
ARGV << 'help' if ARGV.empty?
command = ARGV.shift

# Load the command-handling class
require "#{$ROOT_DIR}/lib/commander"

SearchBot::Commander.new(ARGV).run_command!(command)