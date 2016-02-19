require_relative 'night_reader'
require_relative 'arrange_string_module'
require_relative 'braille'

class FileReader
  def read(filename)
    File.read(filename)
  end

  def write(text)
    filename = ARGV[1]
    File.write(filename, text)
  end
end

class NightRead
  include ArrangeString
  include BrailleMap

  attr_reader :file_reader, :input

  def initialize
    @file_reader = FileReader.new
  end

  def all_letters_valid?
    valid = ["0","."]
    braille_letters.all? do |letter|
      braille_map.values.include?(letter.chars)
    end
  end

  def check_if_empty(input)
    input.gsub(" ","").gsub("\n","") == ""
  end

  def decode_file_to_english(filename = ARGV[0])
    @input = file_reader.read(filename)
    if check_if_empty(input)
      puts "\nNothing to read in #{filename}"
      "Empty File"
    else
      puts "\n#{filename} not empty...Checking if valid..."
      plain = decode_to_english(input)
    end
  end

  def decode_to_english(input)
    nr = NightReader.new(input)
    if all_letters_valid?
      english = file_reader.write(nr.print_output)
      puts "\nCreated '#{ARGV[1]}' containing #{nr.total_character_count} english characters"
    else
      puts "Lines of braille do not match up correctly, or have invalid character and cannot decode correctly untill fixed"
      "Incorrect_line_length"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
nr = NightRead.new
nr.decode_file_to_english
end

puts "\n#{ARGV.inspect}"
