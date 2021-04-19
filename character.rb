class Character
  attr_reader :hand, :sum_of_points, :sum_of_point_when_includeing_11, :losing_flag_due_to_burst, :brackjack_flag

  def reset_hand(character)
    @hand = []
  end

  # 配られたカードを手札に加える
  def receive(dealt_card)
    @hand << dealt_card
  end

  def calculate_points(num_to_adjust_points_when_including_a: NUM_TO_ADJUST_POINTS_WHEN_INCLUDING_A)
    sum_of_points = 0
    count_a = 0
    count_11 = 0

    # とりあえずAを0とカウント
    @hand.each do |card|
      sum_of_points += convert_to_point(card)
      #「A」が何回出たか
      if convert_to_point(card) == 0
        count_a += 1
      end
    end

    count_a.times do |count|
      if sum_of_points <= num_to_adjust_points_when_including_a
        sum_of_points += 11
        count_11 += 1
      else
        sum_of_points += 1
      end
    end
    
    if count_11 == 0
      sum_of_points = [sum_of_points] 
    else
      sum_of_points = [sum_of_points, sum_of_points - num_to_adjust_points_when_including_a] 
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

  def put_up_brackjack_flag
    @brackjack_flag = true
  end

  def put_up_bust_flag
    @losing_flag_due_to_burst = true
  end
end