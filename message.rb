module Message

  def start_message
    puts <<~text
    ----------------------------------
    |                                |
    |           BLACK JACK           |
    |                                |
    ----------------------------------

    text
  end

  def request_plyaer_to_decide_bet_message
    puts <<~text

      現在の所持金は#{@player.money}円です。
      掛け金を入力して下さい。

      text
  end

  def info_bet_money_and_remaining_money
    puts <<~text

          ---------money_information--------
          掛け金： #{@bet}円
          残り所持金 ： #{@player.money}円
          ----------------------------------

          text
  end

  def error_message_for_bet_money
    puts <<~text

          ----------------------------------
          error ： 1以上，かつ所持金以下の数値を入力してください
          ----------------------------------

          text
  end

  def dealer_deals_cards_message
    puts <<~text

      ディーラーがカードを
      2枚ずつ配ります

      text

  end

  def info(players_sum_of_points)
    puts "あなたの手札の合計点数は#{players_sum_of_points}です。"
  end

  def info_players_points
    puts <<~text
        あなたの手札の合計点数は#{@player_points}、もしくは#{@player_points - 10}です。
        ----------------------------------
        text
  end

  def information2
    puts <<~text

        あなたの行動を選択してください

        1.Hit 2.Stand

        text
  end

  def player_point_information3
    puts <<~text
          あなたの手札の合計点数は#{@player_point}です。
          ----------------------------------
          text
  end

  def information3
    puts <<~text
          ----------------------------------
          error ： 1か2を入力してください
          ----------------------------------
          text
  end

  def information4
    puts <<~text

        ディーラーがカードを引き終わりました
        勝敗判定に参りましょう

        text
  end

  def end_message
    puts <<~text

        所持金が0円になりました。
        ----------------------------------

        ゲームオーバー

        text
  end

  def continue_or_end_message
    puts <<~text
        現在の所持金 ： #{player.remaining_money}円
        ----------------------------------

        1.ゲームを続ける 2.ゲームをやめる

        text
  end

  def information5
    puts <<~text

          ゲーム続行

          text
  end

  def information6
    puts <<~text

          ゲーム終了

          text
  end

  def information7
    puts <<~text

          ----------------------------------
          error ： 1か2を入力してください
          ----------------------------------

          text
  end

  def dealer_point_information1
    puts <<~text
    ディーラーの手札の合計点数は#{@dealer_point}です。
    ----------------------------------
    text
  end

  def player_point_information4
    puts <<~text
    あなたの手札の合計点数は#{@player_point}です。
    ----------------------------------
    text
  end

  def information8
    puts <<~text


      合計得点が同点となりました。引き分けです。

      ---------money_information--------
      text
  end

  def information9
    puts <<~text


      ブラックジャック！おめでとうございます。あなたの勝ちです。

      text
  end

  def money_information
    puts "---------money_information--------"
    puts "支払われる金額 ： #{@paid}円"
  end

  def information10
    puts <<~text


      ディーラーがバーストしました。
      おめでとうございます。あなたの勝ちです！

      text
  end

  def information11
    puts <<~text


      ディーラーの勝利。あなたの負けです。

      ---------money_information--------
      text
  end

  def information12
    puts <<~text


      おめでとうございます。あなたの勝ちです。

      text
  end

  def information13
    puts <<~text


    バーストしました。あなたの負けです

    ---------money_information--------
    text
  end
end