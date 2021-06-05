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

# プレイヤーが負ける場合
# numbers = %w[10 9 9 8] #プレイヤー:17，ディーラー:19
# 
# 
# 
# 

# 引き分けの場合
# 
# numbers = %w[9 7 8 10] # 両者17
