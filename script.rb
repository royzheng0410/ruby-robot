require_relative 'lib/robot'
require_relative 'lib/command'
robot = Robot.new
puts "Please enter your commands:"

command = gets
while command
  step = Command.new(command: command, robot: robot)
  result = step.prepare_execution
  puts result unless result.nil?
  command = gets 
end