require_relative 'braille'

class NightWriter
  attr_reader :input, :braille_map, :bm_object

  def initialize(input)
    @input = input
    @bm_object = BrailleMap.new
    @braille_map = bm_object.braille_map
  end

  def print_output
    finalized_input_string
    "#{line1}\n#{line2}\n#{line3}"
  end

  def delete_new_lines
    input.gsub!("\n"," ")
  end

  def index_the_capitals
    index_the_capitals = []
    input.chars.each_with_index do |chars, index|
      if ("A".."Z").include?(chars)
        index_the_capitals << index
      end
    end
    index_the_capitals
  end

  def star_the_capitals_and_downcase
    index_the_capitals.reverse.each do |index|
      input[index] = input[index].downcase
      input.insert(index, "*")
    end
    input
  end

  def braille_wrap
    [@braille_word_top.join.scan(/.{1,80}/), @braille_word_mid.join.scan(/.{1,80}/), @braille_word_bot.join.scan(/.{1,80}/)].transpose
  end

  def index_the_numbers
    index_the_numbers = []
    valid_num = (0..9).to_a.map(&:to_s)
    input.chars.each_with_index do |chars, index|
      if valid_num.include?(chars)
        if index == 0
          index_the_numbers << index
        elsif valid_num.include?(input.chars[index - 1]) == false
          index_the_numbers << index
        end
      end
    end
    index_the_numbers
  end

  def place_pound_at_numbers
    index_the_numbers.reverse.each do |index|
      input.insert(index, "#")
    end
    input
  end

  def finalized_input_string
    delete_new_lines
    star_the_capitals_and_downcase
    place_pound_at_numbers
  end

  def line1
    line1 = []
    input.chars.each do |letter|
      line1 << braille_map[letter][0..1]
    end
    line1.join
  end

  def line2
    line2 = []
    input.chars.each do |letter|
      line2 << braille_map[letter][2..3]
    end
    line2.join
  end

  def line3
    line3 = []
    input.chars.each do |letter|
      line3 << braille_map[letter][4..5]
    end
    line3.join
  end

end
