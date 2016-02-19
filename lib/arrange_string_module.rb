module ArrangeString
  def split_input
    input.chomp.split("\n")
  end

  def line1
    get_line(0)
  end

  def line2
    get_line(1)
  end

  def line3
    get_line(2)
  end

  def get_line(line)
    full_line = ''
    until split_input[line] == nil
      full_line << split_input[line]
      line += 3
    end
    full_line
  end

  def braille_letters
    top, middle, bottom = [line1, line2, line3]
    output = []
    two = 0..1
    until top == ""
      output << top.slice!(two) + middle.slice!(two) + bottom.slice!(two)
    end
    output
  end
  
end
