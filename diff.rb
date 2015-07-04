
class Diff
  def self.diff(a, b)
    a, b = a.split("\n"), b.split("\n")

    removed = []
    unchanged = []

    a.each.with_index do |a_line, a_number|
      b.find.with_index do |b_line, b_number|
        if a_line == b_line
          unless unchanged.empty?
            combination = []
            lines = unchanged[-1][0]...a_number

            lines.to_a.length.times do |i|
              combination << [lines.to_a[i], a[lines][i] ]
            end

            removed.concat( combination )
          end

          unchanged << [a_number, a_line]
          b = b[0...b_number] + b[b_number+1...b.length]
          next b_line
        end

        false
      end
    end

    [b, removed]
  end
end
