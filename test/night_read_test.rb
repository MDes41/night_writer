require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/night_read'

class NightReadTest < MiniTest::Test
  def test_that_empty_file_returns_nothing_to_read
    nr = NightRead.new
    filename = "integration_tests/nothing.txt"
    output = "Empty File"
    assert_equal output, nr.decode_file_to_english(filename)
  end

  def test_all_letters_valid?
    skip
    nr = NightRead.new
    filename = "integration_tests/invalid_braille.txt"
    output =
    assert_equal output, nr.decode_file_to_english(filename)

  end

end
