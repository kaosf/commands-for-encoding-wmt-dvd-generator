require './commands_generator.rb'

if ARGV.size == 1
  path = ARGV[0]
else
  path = ''
end

CommandsGenerator::Episodes.keys.map { |i| i.to_s }.each do |production|
  cg = CommandsGenerator.new path: path, production: production
  print cg.execute
end
