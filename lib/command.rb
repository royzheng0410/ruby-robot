class Command
  attr_reader :command, :robot

  def initialize(attr={})
    @command = attr[:command]
    @robot = attr[:robot]
  end

  def order
    command.split(' ').first
  end

  def start_point
    start_arr = command.split(' ').last.split(",")
    {x: start_arr[0].to_i, y: start_arr[1].to_i, facing: start_arr[2]}
  end

  def prepare_execution
    if need_check_placed? and robot.not_placed?
      return "Please place your robot first"
    else
      robot.execute(self)
    end   
  end

  private

  def need_check_placed?
    order == 'MOVE' || order == 'LEFT' || order == 'RIGHT'
  end
end