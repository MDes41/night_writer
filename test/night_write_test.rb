require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/night_write'
require_relative 'test_helper'

class NightWriteTest < MiniTest::Test

  def test_that_empty_file_returns_nothing_to_read
    nw = NightWrite.new
    filename = "integration_tests/nothing.txt"
    output = "Empty File"
    assert_equal output, nw.encode_file_to_braille(filename)
  end

  def test_all_letters_valid?
    nw = NightWrite.new
    filename = "integration_tests/invalid_eng.txt"
    nw.encode_file_to_braille(filename)
    assert_equal false, nw.all_letters_valid?
  end

  def test_integration_that_file_write_correctly
    nw = NightWrite.new
    filename = "integration_tests/valid_eng.txt"
    output_file = "integration_tests/valid_braille_response.txt"
    ARGV[1] = output_file
    nw.encode_file_to_braille(filename)
    line1 ="..0.0.0.0.0......00.0.0.00.."
    line2 ="..00.00.0..0....00.0000..0.."
    line3 =".0....0.0.0....0.00.0.0....."
    assert_equal File.read(output_file), "#{line1}\n#{line2}\n#{line3}"
  end
end
