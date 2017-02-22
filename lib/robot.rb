class Robot
  FACING = ['NORTH', 'EAST', 'SOUTH', 'WEST']
  attr_accessor :position, :direction
  
  def execute(command)	
    case command.order
    when "PLACE"
      relocate(command.start_point)
    when "MOVE"
      move
    when "LEFT"
      turn('left')
    when "RIGHT"
      turn('right')
    when "REPORT"
      report
    when "EXIT"
      exit
    else
      return "Invalid commands"
    end
  end

  def relocate(commands)
    if check_position(commands[:x], commands[:y]) and check_direction(commands[:facing])
      self.position = {x: commands[:x], y: commands[:y]}
      self.direction = commands[:facing]
      nil
    else
      return "Invalid position"
    end
  end

  def move
    if check_position(self.position[:x] + perform_move[0], self.position[:y] + perform_move[1])
      self.position[:x] += perform_move[0]
      self.position[:y] += perform_move[1]
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
    return "Output: #{self.position[:x]},#{self.position[:y]},#{self.direction}"
  end

  def not_placed?
    self.position.nil?
  end

  private

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
