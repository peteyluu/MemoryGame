require_relative 'board'
require_relative 'humanplayer'
require_relative 'computerplayer'

class MemoryGame
  attr_reader :player, :board, :prev_guess

  def initialize(player)
    @player = player
    @board = Board.new
    @prev_guess = nil
    play
  end

  def play
    puts "Welcome to the Memory Game!"

    until board.won?
      system("clear")
      board.render

      guess = handle_input
      handle_round(guess)
      @prev_guess = guess
      player.previous_guess = guess

      guess = handle_input
      handle_round(guess)

      finalize_round(guess)
    end

    puts "You win!"
  end

  def handle_round(guess)
    make_guess(guess)
    player.update_coords(guess)
    board.render
  end

  def finalize_round(guess)
    x, y = @prev_guess
    i, j = guess
    if board.board[x][y].face_value != board.board[i][j].face_value
      sleep(0.7)
      board.board[x][y].hide
      board.board[i][j].hide
      board.grid[x][y] = "@"
      board.grid[i][j] = "@"
    else
      player.receive_match(prev_guess, guess)
      value = board.board[x][y].face_value
      player.update_known_cards(value)
    end
    @prev_guess = nil
    player.previous_guess = nil
  end

  def handle_input
    guess = player.get_input
    until valid_input?(guess)
      puts "Invalid input!"
      guess = player.get_input
    end
    guess
  end

  def valid_input?(guess)
    x, y = guess
    return false unless x.between?(0, 3) && y.between?(0, 3)
    board.grid[x][y] == "@"
  end

  def make_guess(guess)
    val_pos = board.reveal(guess)
    val = val_pos.first
    pos = val_pos.last
    x, y = pos
    board.grid[x][y] = val
    player.receive_revealed_card(val, pos)
  end
end

if $PROGRAM_NAME == __FILE__
  print "Enter 1, if you are a human player. Enter 2, if you are a computer player: "
  input = gets.chomp.to_i
  if input == 1
    print "Enter your name: "
    input = gets.chomp
    player = HumanPlayer.new(input)
    g = MemoryGame.new(player)
  elsif input == 2
    print "Enter your name: "
    input = gets.chomp
    player = ComputerPlayer.new(input)
    g = MemoryGame.new(player)
  end
end
