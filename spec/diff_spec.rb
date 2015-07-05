require 'rspec'
require 'diff'

describe Diff do
  describe "#diff_strings" do

    a_files = Dir.glob('spec/samples/*_a')
    b_files = Dir.glob('spec/samples/*_b')
    output  = Dir.glob('spec/samples/*_output.rb')

    files = a_files.sort.zip(b_files.sort, output.sort)

    p files

    files.each do |(a, b, output)|
      it a.split(/[\/_]/)[-2] do
        load output
        
        expect(Diff.diff_files(a, b)).to eq(diff_output)
      end
    end
  end
end
