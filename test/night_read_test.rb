require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/night_read'
require_relative 'test_helper'

class NightReadTest < MiniTest::Test
  def test_that_empty_file_returns_nothing_to_read
    nr = NightRead.new
    filename = "integration_tests/nothing.txt"
    output = "Empty File"
    assert_equal output, nr.decode_file_to_english(filename)
  end

  def test_checks_if_string_is_empty
    nr = NightRead.new
    refute nr.check_if_empty("nope")
    assert nr.check_if_empty("")
  end
  
  def test_all_letters_valid?
    nr = NightRead.new
    filename = "integration_tests/invalid_braille.txt"
    nr.decode_file_to_english(filename)
    assert_equal false, nr.all_letters_valid?
  end

  def test_line_not_adding_to_the_same_length_returns_invalid
    nr = NightRead.new
    filename = "integration_tests/incorrect_line_length.txt"
    output = "Incorrect_line_length"
    assert_equal output, nr.decode_file_to_english(filename)
  end

  def test_integration_that_file_write_correctly
    nr = NightRead.new
    filename = "integration_tests/valid_braille.txt"
    output_file = "integration_tests/valid_eng_response.txt"
    ARGV[1] = output_file
    nr.decode_file_to_english(filename)
    assert_equal File.read(output_file), "Hello World "
  end
end
