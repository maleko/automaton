require 'spec_helper'

describe Automaton::Board do

  describe "constants" do

    it "should have a max of 4 for x" do
      expect(Automaton::Board::MAX_X).to eql 4
    end

    it "should have a max of 4 for y" do
      expect(Automaton::Board::MAX_Y).to eql 4
    end

    it "returns 0 to 4 for the list of allowable position x" do
      expect(Automaton::Board::ALLOWABLE_X).to eql 0..4
    end

    it "returns 0 to 4 for the list of allowable position y" do
      expect(Automaton::Board::ALLOWABLE_Y).to eql 0..4
    end

  end

end
