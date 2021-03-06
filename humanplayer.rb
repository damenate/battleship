def get_user_input
  gets.chomp
end

class HumanPlayer < Player
  attr_reader :name, :grid, :ships

  def initialize(name = "Dave")
    @name = name
    @grid = Grid.new
    @ships = []
  end

  def place_ships(ship_length = [2, 3, 3, 4, 5])
    counter = 0
    loop do |s|
      s = ship_length[counter]
      ship = Ship.new(s)
      puts "#{name}, where would you like to place a ship of length #{s}?"
      input = get_user_input
      x = @grid.x_of(input)
      y = @grid.y_of(input)
      puts "Across or Down?"
      input = get_user_input
      if input == "Across"
        across = true
      elsif input == "Down"
        across = false
      end
      if @grid.place_ship(ship, x, y, across)
        counter = counter + 1
        @ships << ship
        if @ships.length == ship_length.length
          break
        end
      else
        puts "Unfortunately, that ship overlaps with one of your other ships.  Please try again."
      end
    end
  end

  def call_shot
    puts "#{@name}, please enter the coordinates for your next shot (e.g. 'B10'):\n"
    input = get_user_input
    x = @grid.x_of(input).to_s
    y = @grid.y_of(input).to_s
    x + y
  end
end
