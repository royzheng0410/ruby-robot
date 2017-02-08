require_relative 'lib/robot'
robot = Robot.new
puts "Please enter your commands:"

commands = gets
while commands
  result = robot.execute(commands)
  puts result unless result.nil?
  commands = gets 
end