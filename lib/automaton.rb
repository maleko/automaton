#
# This is the main file for the Automaton application.  It expects to be called:
#
#   Automaton.application.run
#

require 'highline'
require 'cli-console'
require 'awesome_print'

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

      puts "Initialising Automaton......."
    end

    usage 'Usage: place x,v,f'
    desc  'Places your automaton on the board'
    def place(params)
      ap 'placing'
      ap params
    end

    usage 'Usage: move'
    desc  'Moves your automaton one unit forward'
    def move(params)
      ap 'move'
    end

    usage 'Usage: left'
    desc  'Turns your automaton left'
    def left(params)
      ap 'left'
    end

    usage 'Usage: right'
    desc  'Turns your automaton right'
    def right(params)
      ap 'right'
    end

    usage 'Usage: report'
    desc  'Reports the location of your automaton'
    def report(params)
      ap 'report'
    end



  end

end

io = HighLine.new
automaton = Automaton::Application.new
console = CLI::Console.new(io)

console.addCommand('place',   automaton.method(:place),   'Places automaton')
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

console.start("👾::",[''])
