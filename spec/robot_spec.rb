require 'spec_helper'

describe Robot do
  before do
    @robot = Robot.new
  end

  describe 'Accept commands' do

    it 'should accept place command' do
      expect(@robot).to receive(:relocate).with(['0', '0', 'NORTH'])
      @robot.execute('PLACE 0,0,NORTH')
    end

    it 'should accept move command' do
      @robot.execute('PLACE 0,0,NORTH')
      expect(@robot).to receive(:move)
      @robot.execute('MOVE')
    end

    it 'should accept left command' do
      @robot.execute('PLACE 0,0,NORTH')
      expect(@robot).to receive(:turn).with('left')
      @robot.execute('LEFT')
    end

    it 'should accept right command' do
      @robot.execute('PLACE 0,0,NORTH')
      expect(@robot).to receive(:turn).with('right')
      @robot.execute('RIGHT')
    end

    it 'should accept report command' do
      @robot.execute('PLACE 0,0,NORTH')
      expect(@robot).to receive(:report)
      @robot.execute('REPORT')
    end

    it 'should accept exit command' do
      @robot.execute('PLACE 0,0,NORTH')
      expect(@robot).to receive(:exit)
      @robot.execute('EXIT')
    end

    it 'should return message when robot is not placed before move' do
      expect(@robot.execute('MOVE')).to eq 'Please place your robot first'
    end

    it 'should return message when robot is not placed before turn left' do
      expect(@robot.execute('LEFT')).to eq 'Please place your robot first'
    end

    it 'should return message when robot is not placed before turn right' do
      expect(@robot.execute('RIGHT')).to eq 'Please place your robot first'
    end

    it 'should return message when robot is not placed before report' do
      expect(@robot.execute('REPORT')).to eq 'Please place your robot first'
    end

    it 'should return message when passing invalid message' do
      expect(@robot.execute('STOP')).to eq 'Invalid commands'
    end
  end

  describe 'Relocate robot at a specific position' do
    it 'should be placed to a indicated position' do
      @robot.relocate(['2', '3', 'SOUTH'])
      expect(@robot.position).to eq [2, 3]
      expect(@robot.direction).to eq 'SOUTH'
    end

    it 'should check invalidate position' do
      expect(@robot.relocate(['-1', '2', 'NORTH'])).to eq 'Invalid position'
    end

    it 'should check invalidate direction' do
      expect(@robot.relocate(['1', '2', 'NORTHEAST'])).to eq 'Invalid position'
    end
  end

  describe 'Move robot one unit at a time' do
    it 'should move robot forward' do
      @robot.execute('PLACE 1,1,NORTH')
      @robot.move
      expect(@robot.position).to eq [1, 2]
    end

    it 'should check robot is at edge of the table or not' do
      @robot.execute('PLACE 1,4,NORTH')
      expect(@robot.move).to eq 'Cannot move any further from this direction'     
    end
  end

  describe 'Turn robot to left or right' do 
    it 'should turn robot to right' do
      @robot.execute('PLACE 0,0,NORTH')
      @robot.turn('right')
      expect(@robot.direction).to eq 'EAST'
    end

    it 'should turn robot to left' do
      @robot.execute('PLACE 0,0,NORTH')
      @robot.turn('left')
      expect(@robot.direction).to eq 'WEST'
    end
  end

  describe 'Report output' do 
    it 'should report current position' do 
      @robot.execute('PLACE 0,0,NORTH')
      @robot.execute('MOVE')
      @robot.execute('RIGHT')
      expect(@robot.report).to eq "Output: 0,1,EAST"
    end
  end

  describe 'Check robot is placed or not' do
    it 'should return true when robot is not placed' do
      expect(@robot.send(:not_placed?)).to eq true
    end

    it 'should return false when robot is placed' do
      @robot.execute('PLACE 0,0,NORTH')
      expect(@robot.send(:not_placed?)).to eq false
    end

  describe 'Prepare coordinate for movement'
    it 'should return corret coordinate' do
      @robot.execute('PLACE 0,0,NORTH')
      expect(@robot.send(:perform_move)).to eq [0, 1]
    end
  end

  describe 'Check a given coordinate is valid or not' do
    it 'should return true when it is valid' do 
      expect(@robot.send(:check_position, 1, 2)).to eq true
    end

    it 'should return false when it is invalid' do 
      expect(@robot.send(:check_position, -1, 2)).to eq false
    end
  end

  describe 'Check a given orientation is valid or not' do
    it 'should return true when it is valid' do
      expect(@robot.send(:check_direction, 'SOUTH')).to eq true
    end

    it 'should return false when it is invalid' do
      expect(@robot.send(:check_direction, 'SOUTHEAST')).to eq false
    end
  end 
end