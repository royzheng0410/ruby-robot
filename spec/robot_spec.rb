require 'spec_helper'

describe Robot do
  before do
    @robot = Robot.new
  end

  describe 'Accept commands' do
    it 'should accept place command' do
      @command = Command.new(command: "PLACE 2,3,SOUTH", robot: @robot)
      @robot.execute(@command)
      expect(@robot.position[:x]).to eq 2
      expect(@robot.position[:y]).to eq 3
      expect(@robot.direction).to eq 'SOUTH'
    end

    it 'should accept move command' do
      @robot.position = {x: 2, y: 2}
      @robot.direction = 'NORTH'
      @command = Command.new(command: "MOVE", robot: @robot)
      @robot.execute(@command)
      expect(@robot.position[:x]).to eq 2
      expect(@robot.position[:y]).to eq 3
      expect(@robot.direction).to eq 'NORTH'
    end

    it 'should accept left command' do
      @robot.position = {x: 2, y: 2}
      @robot.direction = 'NORTH'
      @command = Command.new(command: "LEFT", robot: @robot)
      @robot.execute(@command)
      expect(@robot.position[:x]).to eq 2
      expect(@robot.position[:y]).to eq 2
      expect(@robot.direction).to eq 'WEST'
    end

    it 'should accept right command' do
      @robot.position = {x: 2, y: 2}
      @robot.direction = 'NORTH'
      @command = Command.new(command: "RIGHT", robot: @robot)
      @robot.execute(@command)
      expect(@robot.position[:x]).to eq 2
      expect(@robot.position[:y]).to eq 2
      expect(@robot.direction).to eq 'EAST'
    end

    it 'should accept report command' do
      @robot.position = {x: 2, y: 2}
      @robot.direction = 'NORTH'
      @command = Command.new(command: "REPORT", robot: @robot)
      expect(@robot.execute(@command)).to eq 'Output: 2,2,NORTH'
    end

    it 'should accept exit command' do
      @command = Command.new(command: "EXIT", robot: @robot)
      expect(@robot).to receive(:exit)
      @robot.execute(@command)
    end

    it 'should return message when passing invalid message' do
      @command = Command.new(command: "STOP", robot: @robot)
      expect(@robot.execute(@command)).to eq 'Invalid commands'
    end
  end

  describe 'Relocate check start point' do

    it 'should check invalidate position' do
      expect(@robot.relocate({x: -1,y: 2,facing: 'NORTH'})).to eq 'Invalid position'
    end

    it 'should check invalidate direction' do
      expect(@robot.relocate({x: 1,y: 2,facing: 'NORTHEAST'})).to eq 'Invalid position'
    end
  end

  describe 'Check robot at edge of table' do

    it 'should check robot is at edge of the table or not' do
      @robot.position = {x: 1, y: 4}
      @robot.direction = 'NORTH'
      @command = Command.new(command: "MOVE", robot: @robot)
      expect(@robot.execute(@command)).to eq 'Cannot move any further from this direction'     
    end
  end

  describe 'Check robot is placed or not' do
    it 'should return true when robot is not placed' do
      expect(@robot.not_placed?).to eq true
    end

    it 'should return false when robot is placed' do
      @robot.position = {x: 1, y: 1}
      expect(@robot.not_placed?).to eq false
    end
  end
end