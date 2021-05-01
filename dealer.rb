require_relative "character"

class Dealer < Character
  # 1枚カードを引く 伏せた状態の最後のカードから引くのでpop（元のコードはshiftを使用）
  def draw_card(deck)
    deck.cards.pop
  end

  def show_hand_first_time
    puts <<~TEXT

           ----------- #{self.class} 手札 -----------
           1枚目 ： #{@hand[0].card_info}
           2枚目 ： 伏せられている
           -----------------------------------
         TEXT
  end
end
