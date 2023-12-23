require_relative '../src/main'


# Override the output length of diffs for easier debugging
RSpec.configure do |rspec|
  rspec.expect_with :rspec do |c|
    c.max_formatted_output_length = 1000
  end
end


class FileReader
  def self.read_lines(filename)
    File.readlines(filename).map(&:chomp)
  end
end

describe "main" do
  let(:text_file) { "#{Dir.pwd}/spec/text.txt" }
  let(:text_content_arr)  {
  [
    "The Project Gutenberg eBook of The Art of War",
    "    ",
    "This ebook is for the use of anyone anywhere in the United States and",
    "most other parts of the world at no cost and with almost no restrictions",
    "whatsoever. You may copy it, give it away or re-use it under the terms",
    "of the Project Gutenberg License included with this ebook or online",
    "at www.gutenberg.org. If you are not located in the United States,",
    "you will have to check the laws of the country where you are located",
    "before using this eBook.",
    "",
  ]
  }

  describe "default behavior" do
    subject { RbHead.new(text_file) }
    it "returns an array starting with the first 10 lines" do
      expect(subject.run.take(10)).to match_array(text_content_arr)
    end
  end

  describe "configurable number of lines" do
    let(:text_file_1) { "#{Dir.pwd}/spec/text1.txt" }
    it "returns 11 lines when passed in 11" do
      rbhead = RbHead.new(text_file, n: 11)
      text_content_arr.push("Title: The Art of War")
      expect(rbhead.run).to match_array(text_content_arr)
    end

    it "returns all lines if n > file lines" do
      rbhead = RbHead.new(text_file_1, n: 12)
      expect(rbhead.run).to match_array(text_content_arr)
    end
  end

  describe "configurable number of bytes" do
    let(:text_file_2) { "#{Dir.pwd}/spec/text2.txt" }
    it "returns the correct number of bytes if file bytes > ask" do
      rbhead = RbHead.new(text_file, c: 31)
      expected_str = "The Project Gutenberg eBook of "
      expect(rbhead.run).to eq(expected_str)
    end

    it "returns the correct number of bytes if file bytes < ask" do
      rbhead = RbHead.new(text_file_2, c: 30)
      expected_str = "Hello, World"
      expect(rbhead.run).to eq(expected_str)
    end

    it "returns the correct number of bytes if file bytes == ask" do
      rbhead = RbHead.new(text_file_2, c: 12)
      expected_str = "Hello, World"
      expect(rbhead.run).to eq(expected_str)
    end
  end
end
