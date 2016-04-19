ARGV << 'help' if ARGV.empty?

command = ARGV.shift

require "#{$ROOT_DIR}/lib/commander"

SearchBot::Commander.new(ARGV).run_command!(command)