
class Diff
  def self.diff(a, b)
    a, b = a.split("\n"), b.split("\n")

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

    [b, removed]
  end
end
