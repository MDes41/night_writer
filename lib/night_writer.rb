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
    output = ''
    arranged_lines_in_array.each do |line|
      output += line + "\n"
    end
    output = output.chomp
    "#{output}"
  end

  def finalized_input_string
    delete_new_lines
    star_the_capitals_and_downcase
    place_pound_at_numbers
    mark_where_breaks_should_be
  end

  def delete_new_lines
    input.gsub!("\n"," ")
  end

  # def index_the_numbers
  #   index_the_numbers = []
  #   valid_num = (0..9).to_a.map(&:to_s)
  #   input.chars.each_with_index do |chars, index|
  #     if valid_num.include?(chars)
  #       if index == 0
  #         index_the_numbers << index
  #       elsif valid_num.include?(input.chars[index - 1]) == false
  #         index_the_numbers << index
  #       end
  #     end
  #   end
  #   index_the_numbers
  # end
  # def index_the_capitals
  #   index_the_capitals = []
  #   input.chars.each_with_index do |chars, index|
  #     if ("A".."Z").include?(chars)
  #       index_the_capitals << index
  #     end
  #   end
  #   index_the_capitals
  # end
  # def index_the_spaces
  #   index_the_spaces = []
  #   input.chars.each_with_index do |chars, index|
  #     if chars == " "
  #       index_the_spaces << index
  #     end
  #   end
  #   index_the_spaces
  # end

  def index_the_capitals
    input.chars.map.with_index do |char, index|
      index if ("A".."Z").include?(char)
    end.compact
  end


  def star_the_capitals_and_downcase
    index_the_capitals.reverse.each do |index|
      input[index] = input[index].downcase
      input.insert(index, "*")
    end
  end

  def index_the_numbers
    input.chars.map.with_index { |char,index| index if char =~ /[\d]/ &&
    (input[index - 1] =~ /[^\d]/ || index == 0) }.compact
  end

  def place_pound_at_numbers
    index_the_numbers.reverse.each do |index|
      input.insert(index, "#")
    end
  end


  def index_the_spaces
    input.chars.map.with_index do |chars, index|
      index if chars == " "
    end.compact
  end

  def line_wrap_index_arr
    line_wrap_index_arr = []
    wrap = 40
    index_the_spaces.each_with_index do |num, index|
      if wrap - num <= 0
        previous_index = index_the_spaces[index - 1]
        line_wrap_index_arr << previous_index
        wrap = previous_index + 40
      end
    end
  line_wrap_index_arr
  end

  def mark_where_breaks_should_be
    line_wrap_index_arr.reverse.each do |index|
      input.insert(index + 1, "~")
    end
    input
  end

  def each_line
    input.split("~")
  end

  def arranged_lines_in_array
    arranged_lines_in_array = []
    each_line.each do |line|
      arranged_lines_in_array << line1(line)
      arranged_lines_in_array << line2(line)
      arranged_lines_in_array << line3(line)
    end
    arranged_lines_in_array
  end

  def line1(line)
    line1 = []
    line.chars.each do |letter|
      line1 << braille_map[letter][0..1]
    end
    line1.join
  end

  def line2(line)
    line2 = []
    line.chars.each do |letter|
      line2 << braille_map[letter][2..3]
    end
    line2.join
  end

  def line3(line)
    line3 = []
    line.chars.each do |letter|
      line3 << braille_map[letter][4..5]
    end
    line3.join
  end

end
