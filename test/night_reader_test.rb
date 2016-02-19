require_relative "../lib/night_reader"
require_relative 'test_helper'
require "minitest/autorun"
require "minitest/pride"


class NightReaderTest < MiniTest::Test
  attr_reader :hEllo_World7_79, :test

  def setup
    #hEllo World7 79 into braille
    @hEllo_World7_79 = "0...0.0.0.0......00.0.0.00.000...000.0..\n00...00.0..0....00.0000..0.000...0000...\n...0..0.0.0....0.00.0.0...00....00......\n"
    @test = File.read("sample_braille_space_9.txt")
  end

  def test_that_split_input_splits
    #input is 'h'
    nr = NightReader.new("0.\n00\n..")
    assert_equal ["0.","00",".."], nr.split_input
  end

  def test_get_line_gets_line1_line2_and_line3
    nr = NightReader.new("0.\n00\n..")
    assert_equal "0.", nr.line1
    assert_equal "00", nr.line2
    assert_equal "..", nr.line3
  end

  def test_braille_arr
    nr = NightReader.new("0.\n00\n..")
    assert_equal ["0.00.."], nr.set_braille_arr
  end

  def test_convert_to_english
    nr = NightReader.new("0.\n00\n..")
    assert_equal "h", nr.convert_to_english
  end

  def test_convert_to_english_converts_a_whole_string
    #input from variable defined at the top
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "h*ello *world#g #gi ", nr.convert_to_english
  end

  def test_index_the_numbers
    #input from variable defined at the top
    nr = NightReader.new(hEllo_World7_79)
    assert_equal [13, 14, 16, 17, 18], nr.index_the_numbers
  end

  def test_subs_in_the_numbers
    #input from variable defined at the top
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "h*ello *world#7 #79 ", nr.sub_in_numbers
  end

  def test_index_the_capitals_gets_indexes_of_where_the_capital_letters
      #input from variable defined at the top
      nr = NightReader.new(hEllo_World7_79)
      assert_equal [1,7], nr.index_the_capitals
  end

  def test_capitalize_where_capitals_are_indexed
    #input from variable defined at the top
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "h*Ello *World#7 #79 ", nr.capitalize_the_indexed
  end

  def test_strip_the_unnecessary_from_output
    #input from variable defined at the top
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "hEllo World7 79 ", nr.strip_the_unnecessary
  end

  def test_index_the_spaces_marks_the_spaces
    #input from variable defined at the top
    nr = NightReader.new(hEllo_World7_79)
    assert_equal [5, 12, 15], nr.index_the_spaces
  end

  def test_index_the_spaces_marks_the_spaces_with_sample
    #input from sample_english_space_9.txt
    nr = NightReader.new(test)
    output = [9, 19, 29, 39, 49, 59, 69, 79, 89, 99]
    assert_equal output, nr.index_the_spaces
  end

  def test_case_name_with_sample_data
    #input from sample_english_space_9.txt
    nr = NightReader.new(test)
    output = "abcdefghi jklmnopqr stuvwxyza abcdefghi jklmnopqr stuvwxyza abcdefghi jklmnopqr \nstuvwxyza abcdefghi "
    assert_equal output, nr.put_in_new_lines
  end

end
