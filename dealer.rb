require_relative "character.rb"
class Dealer < Character

  def initialize
    @hand = []
  end

  # 1枚カードを配る
  def deals_card(deck)
    deck.cards.pop
  end

  def show_hand_first_time
    puts <<~text

        ------------Dealer 手札------------
        1枚目 ： #{@hand[0].card_info}
        2枚目 ： 伏せられている
        -----------------------------------

         text
  end
end