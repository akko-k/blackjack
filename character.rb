class Character
  attr_reader :hand, :points_list, :bust, :blackjack, :loss

  NUM_TO_ADJUST_POINTS_INCLUDING_A = 10

  def init
    @hand = []
    @bust = false
    @blackjack = false
    @loss = false
  end

  # 配られたカードを手札に加える
  def receive(dealt_card)
    @hand << dealt_card
  end

  def calculate_points
    points_sum = 0
    count_a = 0
    count_11 = 0

    # Aを0とカウント
    @hand.each do |card|
      points_sum += convert_to_point(card)
      #「A」が何回出たか
      if convert_to_point(card) == 0
        count_a += 1
      end
    end

    count_a.times do |count|
      if points_sum <= NUM_TO_ADJUST_POINTS_INCLUDING_A
        points_sum += 11
        count_11 += 1
      else
        points_sum += 1
      end
    end
    
    if count_11 == 0
      @points_list = [points_sum] 
    else
      @points_list = [points_sum, points_sum - NUM_TO_ADJUST_POINTS_INCLUDING_A] 
    end

  end

  def convert_to_point(card)
    case card.number
    when "J" , "Q" , "K"
      card_point = 10
    when "A"
      card_point = 0
    else
      card_point = card.number.to_i
    end
    card_point
  end

  def set_blackjack
    @blackjack = true
  end

  def set_bust
    @bust = true
  end

  def set_loss
    @loss = true
  end
end