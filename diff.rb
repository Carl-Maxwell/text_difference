
class Diff
  def self.diff_strings(a, b)
    a, b = a.split("\n"), b.split("\n")

    [a, b].each do |x|
      x.map!.with_index do |str, number|
        str.extend(Line)
        str.line_number = number

        str
      end
    end

    self.diff(a, b)
  end

  def self.diff_files(a, b)
    # a_file, b_file = File.open(a_file), File.open(b_file)

    # loop over each line & map to Line

    a, b = [a, b].map do |a_or_b|
      lines = []

      File.open(a_or_b) do |file|
        until file.eof?
          str = file.gets.chomp
          str.extend(Line)
          str.line_number = lines.length
          lines << str
        end
      end

      lines
    end

    self.diff(a, b)
  end

  module Line
    attr_accessor :line_number
  end

  protected

  def self.diff(a, b)
    removed = []
    unchanged = []

    a.each.with_index do |a_line, a_line_number|
      b.find.with_index do |b_line, b_line_number|
        if a_line == b_line
          unchanged << [a_line_number, a_line]
          b = b[0...b_line_number] + b[b_line_number+1...b.length]
          next b_line
        end

        false
      end
    end

    a.each.with_index do |a_line, a_line_number|
      unless unchanged.include?([a_line_number, a_line])
        removed << [a_line_number, a_line]
      end
    end

    {added: b, removed: removed}
  end
end
