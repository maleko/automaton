#
# This is the main file for the Automaton application.  It expects to be called:
#
#   Automaton.application.run
#

require 'highline'
require 'cli-console'
require 'awesome_print'
require 'automaton/board'
require 'automaton/daneel'

module Automaton

  class << self

    def application
      @application ||= Automaton::Application.new
    end

  end

  class Application

    private
    extend CLI::Task

    public

    def initialize
      puts "Initialising Board....."
      @board = Automaton::Board.new
      puts "Initialising Automaton......."
      @automaton = Automaton::Daneel.new @board
    end

    usage 'Usage: place x v f (i.e. place 0 0 north)'
    desc  'Places your automaton on the board'
    def place(params)
      puts'placing'
      @automaton.placed_at(params[0].to_i, params[1].to_i, params[2].downcase)
      puts @automaton.report
    end

    usage 'Usage: move'
    desc  'Moves your automaton one unit forward'
    def move(params)
      puts 'moving'
      @automaton.move
      puts @automaton.report
    end

    usage 'Usage: left'
    desc  'Turns your automaton left'
    def left(params)
      puts 'left'
      @automaton.turn_left
      puts @automaton.report
    end

    usage 'Usage: right'
    desc  'Turns your automaton right'
    def right(params)
      puts 'right'
      @automaton.turn_right
      puts @automaton.report
    end

    usage 'Usage: report'
    desc  'Reports the location of your automaton'
    def report(params)
      puts @automaton.report
    end

  end

end

io = HighLine.new
automaton = Automaton::Application.new
console = CLI::Console.new(io)

console.addCommand('place',   automaton.method(:place),   'Places automaton. i.e. "place 0 0 north"')
console.addCommand('move',    automaton.method(:move),    'Move automaton')
console.addCommand('left',    automaton.method(:left),    'Turn automaton left')
console.addCommand('right',   automaton.method(:right),   'Turn automaton right')
console.addCommand('report',  automaton.method(:report),  'Requests automaton to report location')

console.addHelpCommand('help', 'Help')
console.addExitCommand('exit', 'Exit from program')

console.addAlias('quit',    'exit')
console.addAlias('PLACE',   'place')
console.addAlias('MOVE',    'move')
console.addAlias('LEFT',    'left')
console.addAlias('RIGHT',   'right')
console.addAlias('REPORT',  'report')
console.addAlias('q',       'exit')

console.start("👾", [''])
