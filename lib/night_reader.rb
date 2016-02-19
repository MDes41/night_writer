require_relative 'braille'

class NightReader
  attr_reader :input, :braille_map, :bm_object, :output

  def initialize(input)
    @input = input
    @bm_object = BrailleMap.new
    @braille_map = bm_object.braille_map
    @output = ''
  end

  def print_output
    put_in_new_lines
  end
#match_up_input_lines=========================================================
  def split_input
    input.chomp.split("\n")
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

  def get_line(line)
    full_line = ''
    until split_input[line] == nil
      full_line << split_input[line]
      line += 3
    end
    full_line
  end
#get_individual_braille_characters_from_3_input_lines =========================
  def braille_letters
    top, middle, bottom = [line1, line2, line3]
    output = []
    two = 0..1
    until top == ""
      output << top.slice!(two) + middle.slice!(two) + bottom.slice!(two)
    end
    output
  end
#convert_braille_to_english_without_numbers====================================
  def eng_wo_nums
    braille_letters.map do |braille_letter|
      braille_map.key(braille_letter.chars)
    end
  end
#index_all_the_characters_that_are_numbers_and_substitute======================
  def index_the_numbers
    num_lock = false
    eng_wo_nums.map.with_index do |char, index|
      num_lock = false if not_a_number_character?(char)
      num_lock = true if char == "#"
      index if num_lock == true
    end.compact
  end

  def not_a_number_character?(character)
    bm_object.letters_or_numbers.include?(character) == false
  end

  def sub_in_num
    output = eng_wo_nums
    index_the_numbers.reverse.each do |index|
      if output[index] != "#"
        output[index] = letter_to_number(output[index])
      end
    end
    output
  end

  def letter_to_number(letter)
    bm_object.numbers.key(braille_map[letter])
  end
#index_where_capitals_are_and_capitalize_them=================================
  def index_the_capitals
    sub_in_num.map.with_index do |letter, index|
      index if letter == "*"
    end.compact
  end

  def capitalize_the_indexed
    output = sub_in_num
    index_the_capitals.each do |index|
      output[index + 1] = output[index + 1].upcase
    end
    output.join
  end
#take_out_characters_representing_capitals_and_numbers_in_braille=============
  def strip_the_unnecessary
    output = capitalize_the_indexed
    output = output.gsub('*', '')
    output.gsub('#', '')
  end
#mark_spaces_and_add_new_line_marks_at_80_characters_per_line ================
  def put_in_new_lines
    output = strip_the_unnecessary.chars
    spaces = index_the_spaces
    wrap = 80
    spaces.each_with_index do |space, index|
      if wrap - space <= 0
        previous_index = index_the_spaces[index - 1]
        output[previous_index] = " \n"
        wrap = previous_index + 80
      end
    end
    output.join
  end

  def index_the_spaces
    output = strip_the_unnecessary.chars
    output.map.with_index do |letter, index|
      index if letter == " "
    end.compact
  end

end
