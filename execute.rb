require './commands_generator.rb'

if ARGV.size == 2
  path = ARGV[0]
  production = ARGV[1]
else
  path = ''
  production = ARGV[0]
end

cg = CommandsGenerator.new path: path, production: production

print cg.execute
