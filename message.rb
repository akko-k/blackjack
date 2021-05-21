module Message
  def start_msg
    puts <<~TEXT
      ----------------------------------
      |                                |
      |           BLACK JACK           |
      |                                |
      ----------------------------------

    TEXT
  end

  def request_bet_msg(player)
    puts <<~TEXT

      現在の所持金は#{player.money}円です。
      掛け金を入力して下さい。

    TEXT
  end

  def info_bet_money_msg(bet, player)
    puts <<~TEXT

      -------- money_information -------

      掛け金： #{bet}円

      現在の所持金 ： #{player.money}円

      ----------------------------------

    TEXT
  end

  def error_msg_for_bet_money
    puts <<~TEXT

      ---------------------------------------------------------
      error ： 1以上，かつ所持金以下の数値を入力してください。
      ---------------------------------------------------------

    TEXT
  end

  def first_deal_msg(dealer)
    puts <<~TEXT

      #{dealer.class}がカードを2枚ずつ配ります。

    TEXT
  end

  def show_hand_msg(character, if_first_time)
    if if_first_time == Blackjack::FIRST_TIME
      puts <<~TEXT

        ----------- #{character.class} 手札 -----------
        1枚目 ： #{character.hand_cards[0].card_info}
        2枚目 ： 伏せられている
        -----------------------------------
      TEXT
    else
      puts <<~TEXT

        ----------- #{character.class} 手札 -----------
      TEXT
      character.hand_cards.each.with_index(1) do |card, i|
        puts " #{i}枚目 ： #{card.card_info}"
      end
      puts "-----------------------------------"
    end
  end

  def point_msg(character, adjust_num)
    point_msg = "#{character.class}の手札の合計点数は #{character.point}"
    point_msg_2 = "、もしくは #{character.no_adjusted_point} "

    print point_msg

    print point_msg_2 if character.no_adjusted_point

    puts "です。"
  end

  def blackjack_msg(character)
    puts <<~TEXT

      #{character.class}の手札はブラックジャックです！

    TEXT
  end

  def select_action_msg(player)
    puts <<~TEXT

      #{player.class}の行動を選択してください。

      #{Blackjack::HIT_NUM}. Hit #{Blackjack::STAND_NUM}. Stand

    TEXT
  end

  def error_msg_about_action
    puts <<~TEXT
      --------------------------------------
      error ： #{Blackjack::HIT_NUM} か #{Blackjack::STAND_NUM} を入力してください。
      --------------------------------------
    TEXT
  end

  def bust_msg(character)
    puts <<~TEXT

      #{character.class}がバーストしました。

    TEXT
  end

  def players_turn_end_msg(player)
    puts <<~TEXT

      #{player.class}はカードを引き終わりました。

    TEXT
  end

  def dealers_hand_msg(dealer)
    puts <<~TEXT

      #{dealer.class}の手札を確認します。

    TEXT
  end

  def dealer_draw_msg(dealer)
    puts <<~TEXT

      #{Blackjack::STOP_DRAWING_NUM}点未満なので
      #{dealer.class}はもう1枚カードを引きます。

    TEXT
  end

  def compare_point_msg
    puts <<~TEXT

      勝敗判定に参りましょう。

    TEXT
  end

  def type_enter_msg
    puts <<~TEXT

      （ キーボードでEnterキーを押してください。）

    TEXT
  end

  def win_msg(player)
    puts <<~TEXT

      おめでとうございます。#{player.class}の勝ちです!

    TEXT
  end

  def lose_msg(player)
    puts <<~TEXT

      ディーラーの勝利。#{player.class}の負けです。

    TEXT
  end

  def end_in_tie_msg
    puts <<~TEXT

      合計得点が同点となりました。引き分けです。
  
    TEXT
  end

  def dividend_msg(dividend, player)
    puts <<~TEXT

-------- money_information -----------

配当金： #{dividend}円

現在の所持金 ： #{player.money}円

--------------------------------------

    TEXT
  end

  def info_gameover_msg
    puts <<~TEXT

      所持金が0円になりました。

      ゲームオーバー

    TEXT
  end

  def continue_or_end_msg
    puts <<~TEXT

      ゲームを続けますか？
      --------------------------------------

      #{Blackjack::GAME_CONTINUE_NUM}.ゲームを続ける #{Blackjack::GAME_END_NUM}.ゲームをやめる

      --------------------------------------
    TEXT
  end

  def error_msg_about_continue_or_end
    puts <<~TEXT
      ----------------------------------------
        error ： #{Blackjack::GAME_CONTINUE_NUM} か #{Blackjack::GAME_END_NUM} を入力してください。
      ----------------------------------------
    TEXT
  end

  def game_continue_msg
    puts <<~TEXT

      ゲームを続けます。

    TEXT
  end

  def game_end_msg
    puts <<~TEXT

      ゲーム終了

    TEXT
  end
end
