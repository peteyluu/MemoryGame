require_relative 'card'

class Board
  CARDS_VALUES = [2, 3, 4, 5, 6, 7, 8, 9]
  attr_reader :board, :grid

  def self.init_cards
    cards = []
    2.times do |i|
      CARDS_VALUES.each do |card_val|
        cards << Card.new(card_val)
      end
    end
    cards
  end

  def initialize
    @board = Array.new(4) { Array.new(4) }
    cards = Board.init_cards
    populate(cards)
    @grid = init_grid
    # p @board
  end

  def populate(cards)
    shuffled_cards = cards.shuffle
    k = 0
    @board.each_with_index do |row, i|
      row.each_with_index do |col, j|
        @board[i][j] = shuffled_cards[k]
        k += 1
      end
    end
  end

  def render
    header
    @grid.each_with_index do |row, i|
      print "#{i} "
      puts row.join(" ")
    end
  end

  def won?
    @board.flatten.all? { |card| card.face_up == true }
  end

  def reveal(guess)
    x, y = guess
    card = @board[x][y]
    if card.face_up == false
      card.reveal
      return [card.face_value, guess]
    else
      puts "Card is already face up!"
    end
    nil
  end

  def init_grid
    grid = Array.new(4) { Array.new(4) }
    grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        grid[i][j] = "@"
      end
    end
    grid
  end

  def header
    puts "  " + (0..3).to_a.join(" ")
  end
end
