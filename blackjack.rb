require "./deck"
require "./card"
require "./player"
require "./dealer"
require "./message"

class Blackjack
  BUST_NUM = 22
  BLACK_JACK = 21
  HIT_NUM = 1
  STAND_NUM = 2
  DEALER_STOP_DRAWING_NUM = 17
  TIE_RATE = 1
  NOMAL_WIN_RATE = 2
  BLACKJACK_RATE = 2.5
  GAME_CONTINUE_NUM = 1
  GAME_END_NUM = 2

  include Message

  # Blackjackクラスのインスタンス生成前はモジュールを参照できない
  def self.request_player_to_check_money
    player_money = 0
    puts "所持金を入力して下さい。"
    loop do
      player_money = Player.check_money
      break if player_money >= 1
      puts <<~text

             ---------------------------------------------
             error ： 1円以上でゲームに参加してください。
             ---------------------------------------------

           text
    end
    player_money
  end

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
  end

  def start
    start_message

    loop do
      deck = Deck.new

      @dealer.set
      @player.set

      bet = request_player_to_bet

      deal_two_cards_to_each_first(deck)

      if @player.points_list[0] == BLACK_JACK
        @player.determine_points
        info_blackjack_message(@player)
        @player.set_blackjack
      else
        info_points_message(@player)
      end

      start_players_turn(deck) unless blackjack?(@player)
      start_dealers_turn(deck) unless bust?(@player)

      # 両者バーストしてなければ，ポイントによる勝敗判定をする
      unless bust?(@player) && bust?(@dealer)
        judge_winner_by_points
      end

      #Enterキーを押してもらう
      type_enter_message
      $stdin.gets.chomp

      dividend = calculate_dividend(bet)
      @player.settle(dividend)

      info_dividend_remaining_money(dividend)

      if @player.money == 0
        info_end_message
        return
      end

      action_num = request_player_to_decide_continue_or_end

      case action_num
      when GAME_END_NUM
        game_end_message
        exit
      when GAME_CONTINUE_NUM
        game_continue_message
      end
    end
  end

  def request_player_to_bet
    request_player_to_decide_bet_message
    bet = 0
    loop do
      bet = gets.chomp.to_i
      if bet.between?(1, @player.money)
        @player.bet_money(bet)
        info_bet_money_and_remaining_money(bet)
        break
      end
      error_message_for_bet_money
    end
    bet
  end

  def deal_two_cards_to_each_first(deck)
    # 配り方はプレイヤー1枚目→ディーラー1枚目（見せる）→プレイヤー2枚目→ディーラー2枚目（伏せる）
    dealer_deals_cards_first_time_message
    2.times do
      deal_card_to(@player, deck)
      deal_card_to(@dealer, deck)
    end
    @dealer.show_hand_first_time
    @player.show_hand
    @player.calculate_points(bust_num: BUST_NUM)
  end

  def deal_card_to(character, deck)
    drawn_card = @dealer.draw_card(deck)
    character.receive(drawn_card)
  end

  # プレイヤーの番
  def start_players_turn(deck)
    loop do
      action_num = request_player_to_select_hit_or_stand

      case action_num
      when STAND_NUM
        @player.determine_points
        info_end_of_players_turn_message
        break
      when HIT_NUM
        deal_card_to(@player, deck)
        @player.show_hand
        @player.calculate_points(bust_num: BUST_NUM)
        info_points_message(@player)

        if BUST_NUM <= @player.points_list[0]
          info_bust_message(@player)
          @player.set_bust
          @player.set_loss
          player_lose_message
          return
        end
      end
    end
  end

  def request_player_to_select_hit_or_stand
    request_to_select_hit_or_stand_message(hit_num: HIT_NUM, stand_num: STAND_NUM)
    action_num = 0
    loop do
      action_num = @player.select_hit_or_stand
      break if action_num == HIT_NUM || action_num == STAND_NUM
      error_message_about_hit_or_stand(hit_num: HIT_NUM, stand_num: STAND_NUM)
    end
    action_num
  end

  # ディーラーの番
  def start_dealers_turn(deck)
    # 最初に配ったカード2枚を見せる
    check_dealers_first_hand_message

    @dealer.show_hand
    @dealer.calculate_points(bust_num: BUST_NUM)

    # 最初の2枚がブラックジャックかどうかで条件分岐
    if @dealer.points_list[0] == BLACK_JACK
      @dealer.determine_points
      info_blackjack_message(@dealer)
      @dealer.set_blackjack
    else
      info_points_message(@dealer)
    end

    #Enterキーを押してもらう
    type_enter_message
    $stdin.gets.chomp

    if blackjack?(@player)
      @dealer.determine_points
      return
    end

    # 17未満の間はカードを引く
    while @dealer.points_list[0] < DEALER_STOP_DRAWING_NUM
      info_dealer_drow_card(dealer_stop_drawing_num: DEALER_STOP_DRAWING_NUM)
      deal_card_to(@dealer,deck)
      @dealer.show_hand
      @dealer.calculate_points(bust_num: BUST_NUM)
      info_points_message(@dealer)
    end

    case
    when DEALER_STOP_DRAWING_NUM <= @dealer.points_list[0] && @dealer.points_list[0] < BUST_NUM
      @dealer.determine_points
      return
    when BUST_NUM <= @dealer.points_list[0]
      info_bust_message(@dealer)
      @dealer.set_bust
      @player.set_win
      player_win_message
    end
  end

  def judge_winner_by_points
    compare_points_message

    #Enterキーを押してもらう
    type_enter_message
    $stdin.gets.chomp

    @player.show_hand
    blackjack?(@player) ? info_blackjack_message(@player) : info_determined_points_message(@player)
    @dealer.show_hand
    blackjack?(@dealer) ? info_blackjack_message(@dealer) : info_determined_points_message(@dealer)

    case
    when @dealer.points < @player.points
      player_win_message
      @player.set_win
    when @player.points < @dealer.points
      player_lose_message
      @player.set_loss
    else
      judge_winner_when_points_are_same
    end
  end

  def judge_winner_when_points_are_same
    case
    when blackjack?(@player) && ! blackjack?(@dealer)
      player_win_message
      @player.set_win
    when ! blackjack?(@player) && blackjack?(@dealer)
      player_lose_message
      @player.set_loss
    else
      end_in_tie_message
    end
  end

  def blackjack?(character)
    character.blackjack
  end

  def bust?(character)
    character.bust
  end

  def win?
    @player.win
  end

  def loss?
    @player.loss
  end

  def calculate_dividend(bet)
    rate = case
      when ! win? && ! loss?
        1
      when win? && ! blackjack?(@player)
        2
      when win? && blackjack?(@player)
        2.5
      when loss? && ! blackjack?(@dealer)
        0
      when loss? && blackjack?(@dealer)
        -1.5
      end
    (bet * rate).floor
  end

  def info_dividend_remaining_money(dividend)
    breakdown =
    case
    when dividend >= 0
      "配当額"
    else
      "支払額"
    end
    absolute_value_of_dividend = dividend.abs
    info_dividend_remaining_money_message(breakdown, absolute_value_of_dividend)
  end

  def request_player_to_decide_continue_or_end
    request_to_select_continue_or_end_message(game_continue_num: GAME_CONTINUE_NUM, game_end_num: GAME_END_NUM)

    action_num = 0
    loop do
      action_num = @player.select_continue_or_end
      break if action_num == GAME_CONTINUE_NUM || action_num == GAME_END_NUM
      error_message_about_continue_or_end(game_continue_num: GAME_CONTINUE_NUM, game_end_num: GAME_END_NUM)
    end
    action_num
  end
end
