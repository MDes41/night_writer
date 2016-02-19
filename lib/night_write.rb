require_relative 'night_writer'
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

class NightWrite
  include BrailleMap
  attr_reader :file_reader, :input

  def initialize
    @file_reader = FileReader.new
  end

  def all_letters_valid?
    input.gsub("\n","").downcase.chars.all? do |letter|
      braille_map.keys.include?(letter)
    end
  end

  def check_if_empty(input)
    input.gsub(" ","").gsub("\n","") == ""
  end

  def encode_file_to_braille(filename = ARGV[0])
    @input = file_reader.read(filename)
    if check_if_empty(input)
      puts "\nNothing to read in #{filename}"
      "Empty File"
    else
      puts "\n#{filename} not empty...Checking if valid..."
      braille = encode_to_braille(input)
    end
  end

  def encode_to_braille(input)
    nw = NightWriter.new(input)
    if all_letters_valid?
      braille = file_reader.write(nw.print_output)
      puts "\nCreated '#{ARGV[1]}' containing #{nw.total_character_count} characters of braille"
    else
      puts "\nInvalid characters in the message"
      "Incorrect_line_length"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
nw = NightWrite.new
nw.encode_file_to_braille
end
puts "\n#{ARGV.inspect}"
