class Card
  attr_reader :number

  def initialize(mark, number)
    @mark = mark
    @number = number
  end

  def card_info
    "#{@mark} #{@number}"
  end

  def point
    case @number
    when "J", "Q", "K"
      10
    when "A"
      1
    else
      @number.to_i
    end
  end
end
