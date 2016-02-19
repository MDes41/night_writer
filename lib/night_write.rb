require_relative 'night_writer'

class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end

  def write(text)
    filename = ARGV[1]
    File.write(filename, text)
  end

end

class NightWrite
  attr_reader :file_reader

  def initialize
    @file_reader = FileReader.new
  end

  def encode_file_to_braille
    plain = file_reader.read
    braille = encode_to_braille(plain)
  end

  def encode_to_braille(input)
    nw = NightWriter.new(input)
    braille = file_reader.write(nw.print_output)
    puts "Created '#{ARGV[1]}' containing #{nw.total_character_count} characters of braille"
  end
end

nw = NightWrite.new
nw.encode_file_to_braille

puts ARGV.inspect
