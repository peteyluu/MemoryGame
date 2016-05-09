class HumanPlayer
  attr_reader :name
  attr_accessor :previous_guess

  def initialize(name)
    @name = name
    @previous_guess = nil
  end

  def receive_revealed_card(value, pos)

  end

  def receive_match(pos1, pos2)

  end

  def update_known_cards(value)

  end

  def update_coords(pos)

  end

  def get_input
    puts "Enter position (i.e. 0,0): "
    input = gets.chomp.split(',')
    [input.first.to_i, input.last.to_i]
  end
end
