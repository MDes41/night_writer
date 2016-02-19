require_relative 'braille'
require_relative 'arrange_string_module'

class NightReader
  attr_reader :input

  include ArrangeString
  include BrailleMap

  def initialize(input)
    @input = input
    # @bm_object = BrailleMap.new
    # @braille_map = bm_object.braille_map
  end

  def print_output
    put_in_new_lines
  end

#convert_braille_to_english_from_arranged_input_from_module====================
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
    letters_or_numbers.include?(character) == false
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
    numbers.key(braille_map[letter])
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
    wrap = 80
    index_the_spaces.each_with_index do |space, index|
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

  def total_character_count
    strip_the_unnecessary.gsub(" ", "").length
  end

end
