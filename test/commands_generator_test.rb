require './commands_generator.rb'
require 'test/unit'

class CommandsGeneratorTest < Test::Unit::TestCase
  def test
    productions = CommandsGenerator::Episodes.keys.map { |i| i.to_s }
    productions.each do |production|
      cg = CommandsGenerator.new production: production
      assert_equal File.open("test/outputs/#{production}.sh").read, cg.execute
    end
  end
end
