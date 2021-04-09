class Dealer

  def initialize
    @hands = []
  end

  def hands
    @hands
  end

  def first_draw_dealer(deck)

    card = deck.draw
    @hands << card
    puts <<~text

    ------------Dealer手札------------
    1枚目 ： #{card.show}
    2枚目 ： 伏せられている
    ----------------------------------
    text

    card = deck.draw
    @hands << card

  end

  def draw_dealer(deck)
    card = deck.draw
    @hands << card
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