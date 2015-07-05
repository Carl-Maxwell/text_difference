
class Diff
  def self.diff_strings(a, b)
    a, b = a.split("\n"), b.split("\n")

    [a, b].each do |x|
      x.map!.with_index do |str, number|
        Diff.make_line(str, number)
      end
    end

    self.diff(a, b)
  end

  def self.diff_files(a, b)
    a, b = [a, b].map do |a_or_b|
      lines = []

      File.open(a_or_b) do |file|
        until file.eof?
          lines << Diff.make_line(file.gets.chomp, lines.length)
        end
      end

      lines
    end

    self.diff(a, b)
  end

  module Line
    attr_accessor :line_number

    def ==(other)
      normal = super
      return false if normal && self.line_number != other.line_number

      normal
    end
  end

  def self.make_line(str, line_number)
    str.extend(Line)
    str.line_number = line_number
    str
  end

  protected

  def self.diff(a, b)
    removed = []
    unchanged = []

    a.each do |a_line|
      if a_line.empty?
        unchanged << a_line
        next
      end

      b.find.with_index do |b_line, i|
        if a_line == b_line
          unchanged << a_line
          b = b[0...i] + (b[i+1...b.length] || [])
          next b_line
        end

        false
      end
    end

    a.each do |a_line|
      unless unchanged.include?(a_line)
        removed << a_line
      end
    end

    {added: b, removed: removed}
  end
end
