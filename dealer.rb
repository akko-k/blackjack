class Dealer
  attr_reader :hands

  def initialize
    @hands = []
  end

  def first_draw(deck)
    draw(deck)

    puts <<~text

    ------------Dealer手札------------
    1枚目 ： #{card.show}
    2枚目 ： 伏せられている
    ----------------------------------
    text

  end

  def draw(deck)
    draw_card = deck.pop(2)
    @hands << draw_card
  end

  def hands_show_dealer
    puts <<~text

    ------------dealer手札------------

    text

    @hands.each.with_index(1) do |hand, i|
      puts " #{i}枚目 ： #{hand.show}"
    end
  end

end