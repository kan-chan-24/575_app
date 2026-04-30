class Post < ApplicationRecord
  # userモデルとの関連付け
  belongs_to :user

  # 存在チェック
  validates :top, :middle, :bottom, presence: true

  # 音数チェック
  validate :validate_syllable_counts

  # 文字種チェック（追加）
  validate :validate_character_types

  private

  # 音数バリデーション用メソッド
  def validate_syllable_counts
    # 上の句：5音（字余り1音、字足らず4音まで可）
    validate_syllable_count(:top, 5, min: 4, max: 6)
    
    # 中の句：7音（字余り8音、字足らず6音まで可）
    validate_syllable_count(:middle, 7, min: 6, max: 8)
    
    # 下の句：5音（字余り1音、字足らず4音まで可）
    validate_syllable_count(:bottom, 5, min: 4, max: 6)
  end

  # 音数違反にエラーを出すメソッド
  def validate_syllable_count(field, standard, min:, max:)
    value = send(field)
    return if value.blank? # presence バリデーションに任せる（未記載チェック）
    
    count = count_morae(value)
    
    if count < min
      errors.add(field, "は#{min}音以上で入力してください（現在#{count}音）")
    elsif count > max
      errors.add(field, "は#{max}音以内で入力してください（現在#{count}音）")
    end
  end

  # 音数をカウントするメソッド
  def count_morae(text)
    # ひらがな・カタカナに統一
    normalized_text = text.tr('ァ-ン', 'ぁ-ん')
    
    count = 0
    chars = normalized_text.chars
    
    chars.each_with_index do |char, index|
      # 小文字（拗音・促音）は前の文字と合わせて1音なのでスキップ
      next if char =~ /[ぁぃぅぇぉゃゅょゎっ]/
      
      # 長音記号も前の文字と合わせて1音なのでスキップ
      next if char == 'ー' && index > 0
      
      # ひらがな・カタカナは1音としてカウント
      if char =~ /[ぁ-ん]/
        count += 1
      # 数字（半角・全角）も1音としてカウント
      elsif char =~ /[0-9０-９]/
        count += 1
      end
    end
    
    count
  end

  # 文字種チェックのメソッド（追加）
  def validate_character_types
    validate_only_kana(:top)
    validate_only_kana(:middle)
    validate_only_kana(:bottom)
  end

  # ひらがな・カタカナのみかチェック
  def validate_only_kana(field)
    value = send(field)
    return if value.blank? # presence バリデーションに任せる
    
    # ひらがな・カタカナ・長音記号以外が含まれているかチェック
    unless value.match?(/\A[ぁ-んァ-ンー0-9０-９]+\z/)
      errors.add(field, "でひらがな、カタカナ、数字以外が使用されています")
    end
  end

end
