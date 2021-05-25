class Deck
  attr_reader :cards

  # カードデッキを作成し、シャッフルまで行う
  def initialize
    # デッキの配列を生成
    @cards = []

    marks = %w[♤ ♡ ♢ ♧]
    numbers = %w[J J A A] # 両者ブラックジャック
    marks.each do |mark|
      numbers.each do |number|
        # markとnumberの組み合わせを一つずつcardクラスに渡し、それぞれのcardオブジェクトを生成する
        card = Card.new(mark, number)
        # 生成したcardを配列に格納していく
        @cards << card
      end
    end
    @cards#.shuffle!
  end
end
# オリジナル
# numbers = %w[A 2 3 4 5 6 7 8 9 10 J Q K]

# 以下確認用 （※シャッフルなしで実行）

# プレイヤーが勝つ場合
# numbers = %w[9 10 8 9] #プレイヤー:19，ディーラー:17
# numbers = %w[9 Q 10 A] #プレイヤー:ブラックジャック，ディーラー:19
# numbers = %w[10 7 Q 4 A] #プレイヤー:ブラックジャック，ディーラー:3枚目に21になる予定だけど引かずに終わる
# numbers = %w[10 7 Q 6 A] #プレイヤー:ブラックジャック，ディーラー:3枚目にバーストになる予定だけど引かずに終わる
# numbers = %w[J 5 10 8 9] #プレイヤー:19，ディーラー:バースト

# プレイヤーが負ける場合
# numbers = %w[10 9 9 8] #プレイヤー:17，ディーラー:19
# numbers = %w[Q 9 A 10] #プレイヤー:19，ディーラー:ブラックジャック
# numbers = %w[10 Q 4 A 7] #プレイヤー:3枚で21，ディーラー:ブラックジャック
# numbers = %w[J Q 5 A 8] #プレイヤー:バースト，ディーラー:ブラックジャック
# numbers = %w[J 10 5 9 8] #プレイヤー:バースト，ディーラー:19だけど表示されずに終わる

# 引き分けの場合
# numbers = %w[J J A A] # 両者ブラックジャック
# numbers = %w[9 7 8 10] # 両者17

# -----------
# numbers = %w[Q A 7 A Q A] # Aの計算確認用