require 'spec_helper'

describe Robot do
  before do
    @robot = Robot.new
  end

  describe 'Split command input' do
    it 'should get first part of command' do
      @command = Command.new(command: "PLACE 2,3,SOUTH", robot: @robot)
      expect(@command.order).to eq 'PLACE'
    end

    it 'should return second part of command as a hash' do
      @command = Command.new(command: "PLACE 2,3,SOUTH", robot: @robot)
      result = @command.start_point
      expect(result[:x]).to eq 2
      expect(result[:y]).to eq 3
      expect(result[:facing]).to eq 'SOUTH'
    end
  end

  describe 'Prepare execution' do
    it 'should check if it is ok to execute a command' do
      @command = Command.new(command: "MOVE", robot: @robot)
      expect(@command.prepare_execution).to eq 'Please place your robot first'
    end

    it 'should make robot execute itself' do
      @command = Command.new(command: "PLACE 2,3,SOUTH", robot: @robot)
      @command.prepare_execution
      expect(@robot.position[:x]).to eq 2
      expect(@robot.position[:y]).to eq 3
      expect(@robot.direction).to eq 'SOUTH'
    end
  end
end