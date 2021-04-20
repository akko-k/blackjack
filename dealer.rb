require_relative "character.rb"
class Dealer < Character

  # 1枚カードを引く
  def draw_card(deck)
    deck.cards.pop
  end

  def show_hand_first_deal
    puts <<~text

        ----------- #{self.class} 手札 -----------
        1枚目 ： #{@hand[0].card_info}
        2枚目 ： 伏せられている
        -----------------------------------
        text
  end

  def show_hand
    puts <<~text

        ----------- #{self.class} 手札 -----------
        text
      @hand.each.with_index(1) do |card, i|
        puts " #{i}枚目 ： #{card.card_info}"
      end
    puts "-----------------------------------"
  end
end