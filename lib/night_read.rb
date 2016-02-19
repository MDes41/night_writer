require_relative 'night_reader'
require_relative 'arrange_string_module'

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

  attr_reader :file_reader, :input

  def initialize
    @file_reader = FileReader.new
  end

  def all_letters_valid?
    valid = ["0","."]
    x  = braille_letters.join.chars.all? do |letter|
      letter == valid.first || valid.last
    end
  end

  def decode_file_to_english(filename = ARGV[0])
    @input = file_reader.read(filename)
    if input.gsub(" ","").gsub("\n","") == ""
      puts "Nothing to read in #{filename}"
      "Empty File"
    else
      puts "#{filename} not empty...Checking if valid..."
      plain = decode_to_english(input)
    end
  end

  def decode_to_english(input)
    nr = NightReader.new(input)
    if all_letters_valid?
      english = file_reader.write(nr.print_output)
      puts "Created '#{ARGV[1]}' containing #{nr.total_character_count} english characters"
    else
      puts "Braille message is corrupted, please write to file again"
    end
  end
end

# nr = NightRead.new
# nr.decode_file_to_english

puts ARGV.inspect
