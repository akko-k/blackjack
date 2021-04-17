class Character
  attr_reader :hand

  # 配られたカードを手札に加える
  def receive(dealt_card)
    @hand << dealt_card
  end

  def show_hand(character)

    puts "------------#{character.class} 手札------------"
    @hand.each.with_index(1) do |card, i|
      puts " #{i}枚目 ： #{card.card_info}"
    end
    puts "-----------------------------------"
  end
end