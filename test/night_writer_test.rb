require 'minitest/autorun'
require 'minitest/pride'
require_relative 'test_helper'
require_relative '../lib/night_writer'

class NightWriterTest < Minitest::Test

  def test_that_the_letter_a_is_printed_in_braille
    # skip
    nw = NightWriter.new("a")
    output = "0.\n..\n.."
    assert_equal output, nw.print_output
  end

  def test_hello_world_line1_is_printed
    # skip
    nw = NightWriter.new("hello world")
    line1 = "0.0.0.0.0....00.0.0.00"
    assert_equal line1, nw.line1("hello world")
  end

  def test_hello_world_line2_is_printed
    # skip
    nw = NightWriter.new("hello world")
    line2 = "00.00.0..0..00.0000..0"
    assert_equal line2, nw.line2("hello world")
  end

  def test_hellow_world_line3_is_printed
    # skip
    nw = NightWriter.new("hello world")
    line3 = "....0.0.0....00.0.0..."
    assert_equal line3, nw.line3("hello world")
  end

  def test_hello_world_is_on_three_lines
    # skip
    nw = NightWriter.new("hello world")
    line1 = "0.0.0.0.0....00.0.0.00"
    line2 = "00.00.0..0..00.0000..0"
    line3 = "....0.0.0....00.0.0..."
    output = "#{line1}\n#{line2}\n#{line3}"
    assert_equal output, nw.print_output
  end

  def test_input_to_array_wo_newl
    # skip
    nw = NightWriter.new("delete\nnew\nline\nchars\n")
    assert_equal "delete new line chars ", nw.delete_new_lines
  end

  def test_index_the_capitals_gets_array_of_where_capitals_are
    # skip
    nw = NightWriter.new("Hello World")
    assert_equal [0,6], nw.index_the_capitals
  end

  def test_star_the_capitals_and_downcase
    # skip
    nw = NightWriter.new("Hello World")
    nw.star_the_capitals_and_downcase
    assert_equal ("*hello *world"), nw.input
  end

  def test_capital_is_put_in_proper_braille
    # skip
    nw = NightWriter.new("H")
    line1 = "..0."
    line2 = "..00"
    line3 = ".0.."
    output = "#{line1}\n#{line2}\n#{line3}"
    assert_equal output, nw.print_output
  end

  def test_number_adds_the_pound_one_number
    nw = NightWriter.new("7 79")
    assert_equal [0,2], nw.index_the_numbers
  end

  def test_number_adds_the_pound_sign_only_once
    # skip
    nw = NightWriter.new("79 7 7 79990 9")
    nw.place_pound_at_numbers
    assert_equal "#79 #7 #7 #79990 #9", nw.input
  end

  def test_pound_sign_added_and_in_proper_braille
    # skip
    nw = NightWriter.new("7 79")
    line1 = ".000...000.0"
    line2 = ".000...0000."
    line3 = "00....00...."
    output = "#{line1}\n#{line2}\n#{line3}"
    assert_equal output, nw.print_output
  end

  def test_index_the_spaces
    # skip
    sample = (('a'..'z').to_a*8).join.gsub('z',' ')
    nw = NightWriter.new(sample)
    assert_equal [25,51,77,103,129,155,181,207], nw.index_the_spaces
  end

  def test_line_wrap_index_arr
    # skip
    sample = (('a'..'z').to_a*8).join.gsub('z',' ')
    nw = NightWriter.new(sample)
    nw.index_the_spaces
    assert_equal [25, 51, 77, 103, 129, 155, 181], nw.line_wrap_index_arr
  end

  def test_mark_where_breaks_should_be
    # skip
    sample = (('a'..'z').to_a*8).join.gsub('z',' ')
    nw = NightWriter.new(sample)
    nw.index_the_spaces
    output = nw.line_wrap_index_arr
    nw.mark_where_breaks_should_be
    array_of_tildas = nw.input.chars
    array_of_tildas.find_all.with_index do |char, index|
      return index if char == "~"
    end
    assert_equal output, array_of_tildas
  end

  def test_each_line
    # skip
    nw = NightWriter.new("first line~second line")
    assert_equal ["first line", "second line"], nw.each_line
  end

  def test_arrange_lines_in_array
    # skip
    nw = NightWriter.new("h~h")
    output = ['0.','00','..','0.','00','..']
    assert_equal output, nw.arranged_lines_in_array
  end


end
