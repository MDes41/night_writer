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
    wrap = 40
    index_the_spaces.map.with_index do |num, index|
      if wrap - num <= 0
        previous_index = index_the_spaces[index - 1]
        wrap = previous_index + 40
        previous_index
      end
    end.compact
  end

  def mark_where_breaks_should_be
    line_wrap_index_arr.reverse.each do |index|
      input.insert(index + 1, "~")
    end
  end

  def each_line
    input.split("~")
  end

  def arranged_lines_in_array
    each_line.map do |line|
      [line1(line), line2(line), line3(line)]
    end.flatten
  end

  def line1(line)
    line.chars.map do |letter|
      braille_map[letter][0..1]
    end.join
  end

  def line2(line)
    line.chars.map do |letter|
      braille_map[letter][2..3]
    end.join
  end

  def line3(line)
    line.chars.map do |letter|
      braille_map[letter][4..5]
    end.join
  end

end
