class RbHead
  @@bom_length = 3
  def initialize(file_path)
    @file_path = file_path
  end

  def run
    File.open(@file_path, 'r:bom|utf-8') do |file|
      lines = file.readlines.first(10)
      lines.each do |line|
        line.chomp!  # Remove carriage returns and newlines from the end of each line
      end
    end
  end
end
