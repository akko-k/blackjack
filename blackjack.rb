require "./deck"
require "./card"
require "./player"
require "./dealer"
require "./message"

class Blackjack
  include Message

  BUST_NUMBER = 22
  BLACK_JACK = 21
  DEALER_DRAW_NUMBER = 17
  RATE = 2.5

  def self.request_player_to_check_money
    puts "所持金を入力して下さい。"
    money = 0
    loop do
      money = gets.to_i
      break if money >= 1
      puts "1円以上でゲームに参加してください"
    end
    money
  end

  def initialize(player,dealer)
    @player = player
    @dealer = dealer
  end

  def start

    start_message
    @deck = Deck.new
    
    while true
  
      request_player_to_bet

      deal_cards_first_time
      
      @dealer.show_hand_first_time
      @player.show_hand(@player)
      players_sum_of_points = calculate_points(@player)
      info(players_sum_of_points)

      # --------------------------------
      @player_bust_flag = 0
      @dealer_bust_flag = 0


      while true
        request_to_select_action_message
        players_action = gets.chomp.to_i

        if players_action == 1
          deal_card_to(@player)
          @player.show_hand(@player)
          sum_of_points = calculate_points(@player)
          info(sum_of_points)

          if @count_11 == 0
            info(sum_of_points)
          else
            info_when_includeing_11(sum_of_points)
          end

          bust_check

          if @player_bust_flag == 1
            information13
            break
          end

        elsif players_action == 2
          break

        else
          information3

        end

      end

      if @player_bust_flag == 0

        while @dealer_point <= DEALER_DRAW_NUMBER
          @dealer.draw(deck)
          @dealer_point = point_dealer

          bust_check

        end

        information4

        judge

      end

      if @player.money <= 0
        end_message
        break

      else

        continue_or_end_message

        continue = gets.chomp.to_i

        if continue == 1
          information5

        elsif continue == 2
           information6
          break

        else

          information7

        end
      end
    end
  end

  def bust_check
    if @player_point >= BUST_NUMBER
      @player_bust_flag = 1

    elsif @dealer_point >= BUST_NUMBER
      @dealer_bust_flag = 1

    end
  end

  def judge

    @dealer.hands_show_dealer
    @dealer_point = point_dealer

    dealer_point_information1

    @player.hands_show_player
    @player_point = point_player

    player_point_information4 # あなたの手札の合計点数は#{@player_point}です。

    if @dealer_point == @player_point
      information8 # 合計得点が同点となりました。引き分けです。
      @money_show = @player.paid_money(@bet)

    elsif @player_point == BLACK_JACK
      information9 # ブラックジャック！おめでとうございます。あなたの勝ちです。
      @paid = @bet + @bet*RATE
      @money_show = @player.paid_money(@paid.floor)
      money_information # "支払い金額 ： #{@paid}円"

    elsif @dealer_bust_flag == 1
      information10 # ディーラーがバーストしました。おめでとうございます。あなたの勝ちです！
      @paid = @bet + @bet
      @money_show = @player.paid_money(@paid.floor)
      money_information # "支払い金額 ： #{@paid}円"

    elsif @dealer_point > @player_point
      information11

    else
      information12
      @paid = @bet + @bet
      @money_show = @player.paid_money(@paid.floor)
      money_information # puts "支払い金額 ： #{@paid}円"

    end
  end

  private
    
    def request_player_to_bet
      request_plyaer_to_decide_bet_message
      loop do
        @bet = gets.chomp.to_i
        if @bet.between?(1, @player.money)
          @player.bet_money(@bet)
          info_bet_money_and_remaining_money #賭け金と残り所持金を表示
          break
        end
        error_message_for_bet_money # 1以上，かつ所持金以下の数値を入力してください
      end
    end

    # 配り方はプレイヤー1枚目→ディーラー1枚目（見せる）→プレイヤー2枚目→ディーラー2枚目（伏せる）
    def deal_cards_first_time
      dealer_deals_cards_message
      2.times do
        deal_card_to(@player)
        deal_card_to(@dealer)
      end
    end
    
    def deal_card_to(character)
        drawn_card = @dealer.draw_card(@deck)
        character.receive(drawn_card)
    end


    def calculate_points(character)
      sum_of_points = 0
      count_a = 0
      @count_11 = 0

      # とりあえずAを0とカウント
      character.hand.each do |card|
        sum_of_points += convert_to_point(card)
        #「A」が何回出たかを割り出す
        if convert_to_point(card) == 0
          count_a += 1
        end
      end

      count_a.times do |count|
        if sum_of_points <= 10
          sum_of_points += 11
          @count_11 += 1
        else
          sum_of_points += 1
        end
      end
      sum_of_points
  end

  def convert_to_point(card)
    case card.number
    when "J" , "Q" , "K"
      point = 10
    when "A"
      point = 0
    else
      point = card.number.to_i
    end
    point
  end
end