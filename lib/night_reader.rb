require_relative 'braille'

class NightReader
  attr_reader :input, :braille_map, :output, :bm_object

  def initialize(input)
    @input = input
    @bm_object = BrailleMap.new
    @braille_map = bm_object.braille_map
  end

  def print_output
    zip_lines
    "hello world test"
  end

  def split_input
    input.chomp.split("\n")
  end

  def get_line(row)
    full_line = ''
    index = row
    until split_input[index] == nil
      full_line << split_input[index]
      index += 3
    end
    full_line
  end

  def line1
    get_line(0)
  end

  def line2
    get_line(1)
  end

  def line3
    get_line(2)
  end

  def set_braille_arr
    top = line1
    middle = line2
    bottom = line3
    braille_arr = []
    two = 0..1
    until top == ""
      braille_arr << top.slice!(two) + middle.slice!(two) + bottom.slice!(two)
    end
    braille_arr
  end

  def convert_to_english
    set_braille_arr.map do |braille_letter|
      braille_map.key(braille_letter.chars)
    end.join
  end

  def index_the_numbers
    output = convert_to_english.chars
    num = false
    x = output.map.with_index do |char, index|
      num = true if char == "#"
      num = false if char == " "
      index if num == true
    end.compact
  end

  def letter_to_number(letter)
    bm_object.numbers.key(braille_map[letter])
  end

  def sub_in_numbers
    output = convert_to_english.chars
    index_the_numbers.reverse.each do |index|
      if output[index] != "#"
        output[index] = letter_to_number(output[index])
      end
    end
    output.join
  end

  def index_the_capitals
    output = sub_in_numbers.chars
    output.map.with_index do |letter, index|
      index if letter == "*"
    end.compact
  end

  def capitalize_the_indexed
    output = sub_in_numbers.chars
    index_the_capitals.each do |index|
      output[index + 1] = output[index + 1].upcase
    end
    output.join
  end

  def strip_the_unnecessary
    output = capitalize_the_indexed
    output = output.gsub('*', '')
    output.gsub('#', '')
  end


end
