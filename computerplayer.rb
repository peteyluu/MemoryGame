class ComputerPlayer
  attr_reader :name, :known_cards, :matched_cards, :coords
  attr_accessor :previous_guess

  def initialize(name)
    @name = name
    @known_cards = Hash.new { |h, k| h[k] = [] }
    @matched_cards = []
    @coords = generate_coords
    @previous_guess = nil
  end

  def get_input
    curr_coords = candidate_coords

    if !curr_coords.empty?
      if @previous_guess.nil?
        @previous_guess = curr_coords.first
        return @previous_guess
      elsif @previous_guess == curr_coords.first
        @previous_guess = nil
        curr_coords.shift
        return curr_coords.first
      end
    end

    positions = filter_coords
    positions.sample
  end

  def candidate_coords
    known_cards.select { |k, v| v.length == 2 }.values.flatten(1)
  end

  def filter_coords
    values_pos = known_cards.values.flatten(1)
    @coords.each do |pos|
      if values_pos.include?(pos)
        @coords.delete(pos)
      end
    end
    @coords
  end

  def generate_coords
    coords = []
    (0..3).each do |i|
      (0..3).each do |j|
        coords << [i, j]
      end
    end
    coords
  end

  def receive_revealed_card(value, pos)
    if !@known_cards.has_key?(value)
        @known_cards[value] << pos
    else
      coords = @known_cards.values_at(value)
      coords = coords.flatten(1)
      if !coords.include?(pos)
        @known_cards[value] << pos
      end
    end
  end

  def receive_match(pos1, pos2)
    @matched_cards << pos1 << pos2
  end

  def update_known_cards(value)
    @known_cards.delete(value)
  end

  def update_coords(pos)
    @coords.delete(pos)
  end
end
