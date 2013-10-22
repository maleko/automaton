require 'spec_helper'

describe Automaton::Daneel do

  let(:board)     { Automaton::Board.new }
  let(:automaton) { Automaton::Daneel.new(board) }

  let(:pos_x)     { rand Automaton::Board::ALLOWABLE_X }
  let(:pos_y)     { rand Automaton::Board::ALLOWABLE_Y }
  let(:facing)    { Automaton::Daneel::ALLOWABLE_DIRECTIONS[rand(0..3)] }

  describe "#valid_position?" do

    subject { automaton.valid_position?(pos_x, pos_y, facing) }

    context "facing" do

      context "a weird direction" do
        let(:facing)  { "diagonal" }

        it "returns false" do
          expect(subject).to eq false
        end
      end

      context "an allowable direction" do

        it "returns true" do
          expect(subject).to be_true
        end

      end

    end

    context "positioning" do

      it "checks with the board if the position is valid" do
        board.stub(:placeable?).and_return true
        subject
        expect(board).to have_received(:placeable?).with(pos_x, pos_y)
      end

      context "invalid position" do

        let(:placeable) { false }

        it "returns false if the position is invalid" do
          board.stub(:placeable?).and_return placeable
          expect(subject).to eq false
        end

      end

      context "valid position" do

        let(:placeable) { true }

        it "returns false if the position is invalid" do
          board.stub(:placeable?).and_return placeable
          expect(subject).to eq true
        end

      end

    end

  end

  describe "#placed_at" do

    subject { automaton }

    before do
      subject.stub(:valid_position?).and_return(valid_position)
    end

    context "valid position" do

      let(:valid_position) { true }

      before do
        subject.placed_at(pos_x, pos_y, facing)
      end

      it "sets the initial position x" do
        expect(subject.pos_x).to eql pos_x
      end

      it "sets the initial position y" do
        expect(subject.pos_y).to eql pos_y
      end

      it "sets the initial direction" do
        expect(subject.facing).to eql Automaton::Daneel::ALLOWABLE_DIRECTIONS.invert[facing]
      end

    end

    context "invalid position" do

      let(:valid_position) { false }

      before do
        subject.placed_at(pos_x, pos_y, facing)
      end

      it "sets the initial position x" do
        expect(subject.pos_x).to be_nil
      end

      it "sets the initial position y" do
        expect(subject.pos_y).to be_nil
      end

      it "sets the initial direction" do
        expect(subject.facing).to be_nil
      end

    end

  end

end
