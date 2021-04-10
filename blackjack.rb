require "./deck"
require "./card"
require "./player"
require "./dealer"
require "./message"

class Blackjack

  include Message

  BUST_NUMBER = 22
  BLACK_JACK = 21
  DEALER_DRAW_NUMBER = 16
  RATE = 1.5

  def self.request_player_to_enter_money
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

  def start(player_money)

    start_message

    while true
      request_bet(@player)
      
      p deck = Deck.new
      
      @count_11 = 0
      @count_11_dealer = 0
      @player_bust_flag = 0
      @dealer_bust_flag = 0

      information1

      @dealer.first_draw(deck)
      @dealer_point = point_dealer
      @player.first_draw(deck)
      @player_point = point_player

      if @count_11 == 0
        player_point_information1
      else
        player_point_information2
      end

      while true

        information2

        action = gets.chomp.to_i

        if action == 1
          @player.draw_player(deck)
          @player_point = point_player

          if @count_11 == 0
            player_point_information1
          else
            player_point_information2
          end

          bust_check

          if @player_bust_flag == 1
            information13
            break
          end

        elsif action == 2
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
    
    # def build_deck
    #   p @deck = Deck.new
    # end

    def request_bet(player)
      request_bet_message(player)
      loop do
        player.decide_bet
        if player.bet.between?(1, player.money)
          player.bet_money
          info_bet_money_and_remaining_money #賭け金と残り所持金を表示
          break
        else
          error_message_for_bet_money # 1以上，かつ所持金以下の数値を入力してください
        end
      end
    end

    def point_player
      player_point = 0
      count_a = 0

      @player.hands.each do |hand|
        player_point += point(hand)
        #「A」が何回出たかを計算
        if point(hand) == 0
          count_a += 1
        end
      end

      count_a.times do |i|
        if player_point <= 10
          player_point += 11
          @count_11 = 1
        else
          player_point += 1
          @count_11 = 0
        end
      end

      return player_point
    end

    def point_dealer
      dealer_point = 0
      count_a = 0

      @dealer.hands.each do |hand|
        dealer_point += point(hand)
        if point(hand) == 0
          count_a += 1
        end
      end

      count_a.times do |i|
        if dealer_point <= 10
          dealer_point += 11
          @count_11_dealer = 1
        else
          dealer_point += 1
          @count_11_dealer = 0
        end
      end

      dealer_point
    end

    def point(card)
      case card.number
      when "J" || card.number == "Q" || card.number == "K"
        number = 10
      when "A"
        number = 1
      else
        card.number.to_i
      end
    end
end