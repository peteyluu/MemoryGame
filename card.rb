class Card
  attr_reader :face_value, :face_up

  def initialize(value, face_up = false)
    @face_value = value
    @face_up = face_up
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def to_s
    if @face_up == true
      "#{face_value}"
    else
      puts "Cannot reveal card!"
    end
  end
end
