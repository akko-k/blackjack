require_relative "deck"
require_relative "card"
require_relative "player"
require_relative "dealer"
require_relative "message"
require_relative "status"
require_relative "game_sesult"

class Blackjack
  INITIAL_BET = 0
  FIRST_TIME = 1
  NOT_FIRST_TIME = 0
  BLACKJACK_NUM = 21
  HIT_NUM = 1
  STAND_NUM = 2
  STOP_DRAWING_NUM = 17
  BLACKJACK_RATE = 2.5
  NORMAL_WIN_RATE = 2
  TIE_RATE = 1
  LOSS_RATE = 0
  GAME_CONTINUE_NUM = 1
  GAME_END_NUM = 2

  include Message
  include Status

  def initialize(dealer, player)
    @dealer = dealer
    @player = player
  end

  def start
    start_msg

    loop do
      @deck = Deck.new

      @dealer.reset
      @player.reset

      @bet = request_bet

      deal_first

      start_players_turn unless @player.blackjack?
      start_dealers_turn unless @player.bust?

      judge_winner
      info_judge
      settle_dividend
      continue_or_end
    end
  end

  private

  def request_bet
    request_bet_msg(@player)
    bet = INITIAL_BET
    loop do
      bet = @player.decide_bet
      if bet.between?(1, @player.money)
        @player.bet_money(bet)
        info_bet_money_msg(bet, @player)
        break
      end
      error_msg_for_bet_money
    end
    bet
  end

  def deal_first
    # 配り方はプレイヤー1枚目→ディーラー1枚目（見せる）→プレイヤー2枚目→ディーラー2枚目（伏せる）
    first_deal_msg(@dealer)
    2.times do
      deal_card_to(@player)
      deal_card_to(@dealer)
    end
    show_hand_msg(@dealer, first_time: true)
    show_hand_msg(@player)

    @player.change(Status::BLACKJACK) if @player.point == BLACKJACK_NUM
    info_status_or_points(@player)
  end

  def deal_card_to(character)
    drawn_card = @dealer.draw_card(@deck)
    character.receive(drawn_card)
  end

  def start_players_turn
    loop do
      action_num = request_hit_or_stand

      case action_num
      when STAND_NUM
        players_turn_end_msg(@player)
        break
      when HIT_NUM
        deal_card_to(@player)
        show_hand_msg(@player)
        info_status_or_points(@player)

        if @player.point > BLACKJACK_NUM
          @player.change(Status::BUST)
          info_status_or_points(@player)
          break
        end
      end
    end
  end

  def request_hit_or_stand
    select_action_msg(@player)
    action_num = 0
    loop do
      action_num = @player.select_action
      break if [HIT_NUM, STAND_NUM].include?(action_num)

      error_msg_about_action
    end
    action_num
  end

  def start_dealers_turn
    # 最初に配ったカード2枚を見せる
    dealers_hand_msg(@dealer)
    show_hand_msg(@dealer)

    @dealer.change(Status::BLACKJACK) if @dealer.point == BLACKJACK_NUM
    info_status_or_points(@dealer)

    return if @player.blackjack?

    # Enterキーを押してもらう
    type_enter_msg
    $stdin.gets.chomp

    # 17未満の間はカードを引く
    while @dealer.point < STOP_DRAWING_NUM
      dealer_draw_msg(@dealer)
      deal_card_to(@dealer)
      show_hand_msg(@dealer)
      info_status_or_points(@dealer)
    end

    if @dealer.point > BLACKJACK_NUM
      @dealer.change(Status::BUST)
      info_status_or_points(@dealer)
    end
  end

  def info_status_or_points(character)
    if character.blackjack?
      blackjack_msg(character)
    elsif character.bust?
      bust_msg(character)
    else
      point_msg(character, Character::ADJUST_NUM)
    end
  end

  def judge_winner
    compare_point_msg

    # Enterキーを押してもらう
    type_enter_msg
    $stdin.gets.chomp

    show_hand_msg(@player)
    info_status_or_points(@player)
    
    show_hand_msg(@dealer)
    info_status_or_points(@dealer)

    if @dealer.bust?
      @player.set(GameResult::WIN)
    elsif @player.bust?
      @player.set(GameResult::LOSS)
    elsif @dealer.point < @player.point
      @player.set(GameResult::WIN)
    elsif @player.point < @dealer.point
      @player.set(GameResult::LOSS)
    else
      judge_winner_when_same_point
    end
  end

  def judge_winner_when_same_point
    if @player.blackjack? && !@dealer.blackjack?
      @player.set(GameResult::WIN)
    elsif !@player.blackjack? && @dealer.blackjack?
      @player.set(GameResult::LOSS)
    end
  end

  def info_judge
    if @player.win?
      win_msg(@player)
    elsif @player.loss?
      lose_msg(@player)
    else
      end_in_tie_msg
    end
  end

  def settle_dividend
    # Enterキーを押してもらう
    type_enter_msg
    $stdin.gets.chomp

    dividend = calculate_dividend
    @player.settle(dividend)

    dividend_msg(dividend, @player)
    if @player.money == 0
      info_gameover_msg
      exit
    end
  end

  def calculate_dividend
    rate =
      if @player.win? && @player.blackjack?
        BLACKJACK_RATE
      elsif @player.win? && !@player.blackjack?
        NORMAL_WIN_RATE
      elsif !@player.win? && !@player.loss?
        TIE_RATE
      elsif @player.loss?
        LOSS_RATE
      end
    (@bet * rate).floor
  end

  def continue_or_end
    action_num = request_continue_or_end

    case action_num
    when GAME_END_NUM
      game_end_msg
      exit
    when GAME_CONTINUE_NUM
      game_continue_msg
    end
    action_num
  end

  def request_continue_or_end
    continue_or_end_msg

    action_num = 0
    loop do
      action_num = @player.select_action
      break if [GAME_CONTINUE_NUM, GAME_END_NUM].include?(action_num)

      error_msg_about_continue_or_end
    end
    action_num
  end
end
