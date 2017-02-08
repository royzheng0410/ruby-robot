class Robot
  FACING = ['NORTH', 'EAST', 'SOUTH', 'WEST']
  attr_accessor :position, :direction 

  def initialize(attr={})
    @position = attr[:position]
    @direction = attr[:direction]
  end 

  def execute(commands)	
    case commands.split(' ').first
    when "PLACE"
      relocate(commands.split(' ').last.split(","))
    when "MOVE"
      return "Please place your robot first" if not_placed?
      move
    when "LEFT"
      return "Please place your robot first" if not_placed?
      turn('left')
    when "RIGHT"
      return "Please place your robot first" if not_placed?
      turn('right')
    when "REPORT"
      return "Please place your robot first" if not_placed?
      report
    when "EXIT"
      exit
    else
      return "Invalid commands"
    end
  end

  def relocate(commands)
    if check_position(commands[0].to_i, commands[1].to_i) and check_direction(commands[2])
      self.position = [commands[0].to_i, commands[1].to_i]
      self.direction = commands[2]
      nil
    else
      return "Invalid position"
    end
  end

  def move
    if check_position(self.position[0] + perform_move[0], self.position[1] + perform_move[1])
      self.position[0] += perform_move[0]
      self.position[1] += perform_move[1]
      nil
    else
      return "Cannot move any further from this direction"
    end
  end

  def turn(orientation)
    current_index = FACING.index(self.direction)
    new_index = orientation == 'left' ? current_index - 1 : current_index + 1
    self.direction = FACING[new_index]
    nil
  end

  def report
    return "Output: #{self.position[0]},#{self.position[1]},#{self.direction}"
  end

  private

  def not_placed?
    self.position.nil?
  end

  def perform_move
    case self.direction
    when "NORTH"
      [0, 1]
    when "SOUTH"
      [0, -1]
    when "EAST"
      [1, 0]
    when "WEST"
      [-1, 0]
    end
  end

  def check_position(x_axis, y_axis)
    if x_axis < 0 or y_axis < 0 or x_axis > 4 or y_axis > 4
      false
    else
      true
    end 	
  end

  def check_direction(command)
    unless FACING.include? command
      false
    else
      true
    end
  end
end
