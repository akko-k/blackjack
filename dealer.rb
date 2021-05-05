require_relative "character"

class Dealer < Character
  # 1枚カードを引く 伏せた状態の最後のカードから引くのでpop（元のコードはshiftを使用）
  def draw_card(deck)
    deck.cards.pop
  end
end
