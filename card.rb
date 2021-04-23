class Card
  attr_reader :number

  def initialize(mark, number)
    @mark = mark
    @number = number
  end

  def card_info
    return "#{@mark} #{@number}"
  end
end
