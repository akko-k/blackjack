require_relative 'character'

class Dealer < Character
  # 1枚カードを引く
  def draw_card(deck)
    deck.cards.pop
  end
end
