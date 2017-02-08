require_relative 'lib/robot'
robot = Robot.new
puts "Please enter your commands:"

commands = gets
while commands
  robot.execute(commands)
  commands = gets 
end