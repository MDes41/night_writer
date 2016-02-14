require 'minitest/autorun'
require 'minitest/pride'
require_relative 'test_helper'
require_relative '../lib/night_writer'

class NightWriterTest < Minitest::Test

  def test_that_the_letter_a_is_printed_in_braille
    nw = NightWriter.new("a")
    output = "0.\n..\n.."

    assert_equal output, nw.print_output
  end

  def test_hello_world_line1_is_printed
    nw = NightWriter.new("hello world")
    line1 = "0.0.0.0.0....00.0.0.00"

    assert_equal line1, nw.line1
  end

  def test_hello_world_line2_is_printed
    nw = NightWriter.new("hello world")
    line2 = "00.00.0..0..00.0000..0"

    assert_equal line2, nw.line2
  end

  def test_hellow_world_line3_is_printed
    nw = NightWriter.new("hello world")
    line3 = "....0.0.0....00.0.0..."
    assert_equal line3, nw.line3
  end

  def test_hello_world_is_on_three_lines
    nw = NightWriter.new("hello world")
    line1 = "0.0.0.0.0....00.0.0.00"
    line2 = "00.00.0..0..00.0000..0"
    line3 = "....0.0.0....00.0.0..."
    output = "#{line1}\n#{line2}\n#{line3}"

    assert_equal output, nw.print_output
  end

  def test_input_to_array_wo_newl
    nw = NightWriter.new("delete\nnew\nline\nchars\n")

    assert_equal "delete new line chars ", nw.delete_new_lines
  end

  def test_index_the_capitals_gets_array_of_where_capitals_are
    nw = NightWriter.new("Hello World")

    assert_equal [0,6], nw.index_the_capitals
  end

  def test_star_the_capitals_and_downcase
    nw = NightWriter.new("Hello World")

    assert_equal ("*hello *world"), nw.star_the_capitals_and_downcase
  end

  def test_capital_is_put_in_proper_braille
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
    nw = NightWriter.new("79 7 7 79990 9")

    assert_equal "#79 #7 #7 #79990 #9", nw.place_pound_at_numbers
  end
end
