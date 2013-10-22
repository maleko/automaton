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

  describe "#placeable?" do

    let(:board) { Automaton::Board.new }
    let(:pos_x) { 0 }
    let(:pos_y) { 0 }

    subject     { board.placeable?(pos_x, pos_y) }

    context "with negative numbers" do

      context "for x" do

        let(:pos_x) { -1 }

        it { should == false }

      end

      context "for y" do

        let(:pos_y) { -1 }

        it { should == false }

      end

    end

    context "within the range" do

      context "for x" do

         let(:pos_x) { rand Automaton::Board::ALLOWABLE_X }

         it { should be_true }

      end

      context "for y" do

         let(:pos_y) { rand Automaton::Board::ALLOWABLE_Y }

         it { should be_true }

      end

    end

    context "over the maximum number" do

      context "for x" do

        let(:pos_x) { 5 }

        it { should == false }

      end

      context "for y" do

        let(:pos_y) { 5 }

        it { should == false }

      end

    end

  end


end
