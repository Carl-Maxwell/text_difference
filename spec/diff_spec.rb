require 'rspec'
require 'diff'

describe Diff do
  describe "#diff_strings" do

    a_files = Dir.glob('./samples/*_a')
    b_files = Dir.glob('./0987654 samples/*_b')
    output  = Dir.glob('./samples/*_output')

    files = a_files.sort.zip(b_files.sort, output.sort)

    files.each do |(a, b, output)|
      it "" do
        load output
        expect(Diff.diff_files(a, b)).to eq(diff_output)
      end
    end
  end
end
