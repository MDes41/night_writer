require_relative "../lib/night_reader"
require "minitest/autorun"
require "minitest/pride"


class NightReaderTest < MiniTest::Test
  attr_reader :hEllo_World7_79, :test

  def setup
    #hEllo World7 79 into braille
    @hEllo_World7_79 = "0...0.0.0.0......00.0.0.00.000...000.0..\n00...00.0..0....00.0000..0.000...0000...\n...0..0.0.0....0.00.0.0...00....00......\n"
    @test = File.read("braille.txt")
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
    #input froem variable defined at the top
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "h*ello *world#g #gi ", nr.convert_to_english
  end

  def test_index_the_numbers
    #input froem variable defined at the top
    nr = NightReader.new(hEllo_World7_79)
    assert_equal [13, 14, 16, 17, 18], nr.index_the_numbers
  end

  def test_subs_in_the_numbers
    #input froem variable defined at the top
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "h*ello *world#7 #79 ", nr.sub_in_numbers
  end

  def test_index_the_capitals_gets_indexes_of_where_the_capital_letters
      #input froem variable defined at the top
      nr = NightReader.new(hEllo_World7_79)
      assert_equal [1,7], nr.index_the_capitals
  end

  def test_capitalize_where_capitals_are_indexed
    #input froem variable defined at the top
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "h*Ello *World#7 #79 ", nr.capitalize_the_indexed
  end

  def test_strip_the_unnecessary_from_output
    #input froem variable defined at the top
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "hEllo World7 79 ", nr.strip_the_unnecessary
  end
end
