require 'minitest/autorun'
require 'minitest/pride'
require_relative 'test_helper'
require_relative '../lib/braille'

class BrailleMapTest < Minitest::Test

  def test_braille_converts_a_to_correct_braille
    bm = BrailleMap.new
    braille = bm.lowercase

    assert_equal ["0",".",".",".",".","."], braille["a"]
    assert_equal ["0",".","0",".",".","."], braille["b"]
    assert_equal ["0",".",".","0","0","0"], braille["z"]
    assert_equal 26, braille.count
  end

  def test_that_space_is_added_to_map
    bm = BrailleMap.new
    braille = bm.space

    assert_equal [".",".",".",".",".","."], braille[" "]
    assert_equal 1, braille.count
  end

  def test_that_capital_is_added
    bm = BrailleMap.new
    braille = bm.capital

    assert_equal [".",".",".",".",".","0"], braille["*"]
    assert_equal 1, braille.count
  end

  def test_that_braille_map_is_created
    bm = BrailleMap.new
    braille = bm.braille_map

    assert_equal 39, braille.count
  end
end
