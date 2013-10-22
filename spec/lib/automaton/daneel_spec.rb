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

        it "returns true if the position is valid" do
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
      subject.placed_at(pos_x, pos_y, facing)
    end

    context "valid position" do

      let(:valid_position) { true }

      it "sets the initial position x" do
        expect(subject.pos_x).to eql pos_x
      end

      it "sets the initial position y" do
        expect(subject.pos_y).to eql pos_y
      end

      it "sets the initial direction" do
        expect(subject.facing).to eql facing
      end

      it "returns true" do
        expect(subject.placed_at(pos_x, pos_y, facing)).to be_true
      end

    end

    context "invalid position" do

      let(:valid_position) { false }

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

  describe "#turn_left" do

    subject { automaton }

    context "placed" do

      before do
        subject.placed_at(pos_x, pos_y, facing)
        subject.turn_left
      end

      context "originally facing north" do

        let(:facing) { "north" }

        it "should face west" do
          expect(subject.facing).to eql "west"
        end

      end

      context "originally facing east" do

        let(:facing) { "east" }

        it "should face north" do
          expect(subject.facing).to eql "north"
        end

      end

      context "originally facing south" do

        let(:facing) { "south" }

        it "should face east" do
          expect(subject.facing).to eql "east"
        end

      end

      context "originally facing west" do

        let(:facing) { "west" }

        it "should face south" do
          expect(subject.facing).to eql "south"
        end

      end

    end

    context "unplaced" do

      it "returns false" do
        expect(subject.turn_left).to eql false
      end

    end

  end

  describe "#turn_right" do

    subject { automaton }

    context "placed" do

      before do
        subject.placed_at(pos_x, pos_y, facing)
        subject.turn_right
      end

      context "originally facing north" do

        let(:facing) { "north" }

        it "should face east" do
          expect(subject.facing).to eql "east"
        end

      end

      context "originally facing east" do

        let(:facing) { "east" }

        it "should face south" do
          expect(subject.facing).to eql "south"
        end

      end

      context "originally facing south" do

        let(:facing) { "south" }

        it "should face west" do
          expect(subject.facing).to eql "west"
        end

      end

      context "originally facing west" do

        let(:facing) { "west" }

        it "should face north" do
          expect(subject.facing).to eql "north"
        end

      end

    end

    context "unplaced" do

      it "returns false" do
        expect(subject.turn_right).to eql false
      end

    end

  end

  describe "#report" do

    subject { automaton }

    context "placed" do

      before do
        subject.placed_at pos_x, pos_y, facing
      end

      it "reports its position" do
        expect(subject.report).to eql "My current position is X:#{pos_x} Y:#{pos_y} facing #{facing}"
      end

    end

    context "unplaced" do

      it "denies all knowledge of its position" do
        expect(subject.report).to eql "I have no idea where I am"
      end

    end

  end

  describe "#move" do

    subject { automaton }

    context "placed" do

      before do
        subject.placed_at pos_x, pos_y, facing
        subject.move
      end

      context "move outside of board" do

        context "western edge" do

          let(:pos_x)   { 0 }
          let(:facing)  { "west" }

          it "stays where it is" do
            expect(subject.pos_x).to eq pos_x
          end

          it "faces the same direction" do
            expect(subject.facing).to eq facing
          end

        end

        context "eastern edge" do

          let(:pos_x)   { 4 }
          let(:facing)  { "east" }

          it "stays where it is" do
            expect(subject.pos_x).to eq pos_x
          end

          it "faces the same direction" do
            expect(subject.facing).to eq facing
          end

        end

        context "northern edge" do

          let(:pos_y)   { 4 }
          let(:facing)  { "north" }

          it "stays where it is" do
            expect(subject.pos_y).to eq pos_y
          end

          it "faces the same direction" do
            expect(subject.facing).to eq facing
          end

        end

        context "southern edge" do

          let(:pos_y)   { 0 }
          let(:facing)  { "south" }

          it "stays where it is" do
            expect(subject.pos_y).to eq pos_y
          end

          it "faces the same direction" do
            expect(subject.facing).to eq facing
          end

        end

      end


      context "move within board" do

        let(:pos_x)   { 3 }
        let(:pos_y)   { 3 }

        context "facing north" do

          let(:facing)  { "north" }

          it "moves forward one step" do
            expect(subject.pos_y).to eq 4
          end

          it "doesn't change the other axis" do
            expect(subject.pos_x).to eq pos_x
          end

        end

        context "facing south" do

          let(:facing)  { "south" }

          it "moves forward one step" do
            expect(subject.pos_y).to eq 2
          end

          it "doesn't change the other axis" do
            expect(subject.pos_x).to eq pos_x
          end

        end

        context "facing east" do

          let(:facing)  { "east" }

          it "moves forward one step" do
            expect(subject.pos_x).to eq 4
          end

          it "doesn't change the other axis" do
            expect(subject.pos_y).to eq pos_y
          end

        end

        context "facing west" do

          let(:facing)  { "west" }

          it "moves forward one step" do
            expect(subject.pos_x).to eq 2
          end

          it "doesn't change the other axis" do
            expect(subject.pos_y).to eq pos_y
          end

        end

      end

    end

    context "not placed yet" do

      it "returns false" do
        expect(subject.move).to eql false
      end

    end

  end

  describe "#placed?" do

    subject { automaton }

    context "has been placed" do

      before do
        subject.placed_at pos_x, pos_y, facing
      end

      it "returns true" do
        expect(subject.placed?).to be_true
      end

    end

    context "has not been placed yet" do

      it "returns false" do
        expect(subject.placed?).to eql false
      end

    end

  end

end
