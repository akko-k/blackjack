class Player
  attr_reader :hands, :money, :bet

  

  def initialize(money)
    @hands = []
    @money = money
  end

  def decide_bet
    @bet = gets.chomp.to_i
  end

  def bet_money
    @money -= @bet
  end

  def paid_money(money)
    @money += money
  end

  def first_draw(deck)
    card = deck.draw
    @hands << card
    card = deck.draw
    @hands << card
    puts "------------Player手札------------"
    @hands.each.with_index(1) do |hand, i|
      puts " #{i}枚目 ： #{hand.show}"
    end
  end

  def draw_player(deck)
    card = deck.draw
    @hands << card

    hands_show_player
  end

  def hands_show_player
    puts <<~text

    ------------Player手札------------
    text

    @hands.each.with_index(1) do |hand, i|
      puts " #{i}枚目 ： #{hand.show}"
    end
  end
end