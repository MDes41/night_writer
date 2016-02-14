require_relative 'braille'

class NightReader
  attr_reader :input

  def initialize(input)
    @input = input
    @braille_map = BrailleMap.new.braille_map
  end

  def print_output
    zip_lines
    "hello world test"
  end

  def split_input
    input.split("\n")
  end

  def line1
    line1 = []
    index = 0
    until split_input[index] == nil
      line1 << split_input[index]
      index += 3
    end
    line1
  end

  def line2
    line2 = []
    index = 0
    until split_input[index] == nil
      line2 << split_input[index + 1]
      index += 3
    end
    line2
  end

  def line3
    line3 = []
    index = 0
    until split_input[index] == nil
      line3 << split_input[index + 2]
      index += 3
    end
    line3
  end

  def zip_lines
    all_lines = line1.zip(line2, line3)
    require "pry"
    binding.pry
  end
end
